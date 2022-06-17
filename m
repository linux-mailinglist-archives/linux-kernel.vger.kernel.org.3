Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E02554F6F2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381923AbiFQLrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381835AbiFQLrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:47:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BC16CF55
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:47:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id e5so2199524wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/hNIOJ5hTTtx9TBs8QFTNJBtJBcEBlHU7N6Sy/oc5s0=;
        b=X1ObqiPYXvwHaBHTfpC53aI4725mpZnLSUYqGsbkxDtAMs4SkXx+FWqBU6F3choNie
         4aW+2CzHAYat3Y/BPWU2jbD3I2JnM4U/MiEmuI/3ehiA8O1U4yJXDZkvGl9wulKG1h/E
         u+Maa3POJUgr466ZCBvBwCGd8X4mXmnhe1WnjYivKYC8ssZA31vb8RzhkueEEZguFHOf
         43SzyWZLjiWxarTu4NLYpkUl5a4w/9v8mfU4yaNdas9BADfB+LQJWsfay0E1hXm90Yxq
         LDNMfqn1IfJBdkG56Bi/vI/XoJ2P/g5l+jY7/Grr1NqyFeU+waX5GEqniDkuhHY4osTk
         tPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/hNIOJ5hTTtx9TBs8QFTNJBtJBcEBlHU7N6Sy/oc5s0=;
        b=J+xe/rWrbMIFdo+tDwSCKvlH47sSMR5CSJWJ0GORR8506H0rE17SVae8ofqZT+2G+v
         ptaB37dKWo7gCzHb79HVJIq96vCES1cHJA/GBhrBi07HXIRXBqMMZ844Asa+pCxZns+Q
         OpIRokqtBI7ZGzANdoGfbuvt3/1y89/jevW1S7Yr1FY6rxX+5NN52xmTs147Q0xq0imZ
         lADweTnvitHCkakiZ+j58cPIbkOlAQQsuW429J1cRlGjCx+4Ysd9vH6HAijaXEWEt/ZZ
         4uwUHXZoMM/Va59y14Y1j7QENA2fLYH2cHn/QLtWTsLjtB/6FV1ElpPp+E+x45dzkVQi
         aA8Q==
X-Gm-Message-State: AJIora+WuHj+o3oqZANapS2jbcRAWe9mi+R59qKt7r6OZC1+VUmZSCzZ
        l9AWUq5+fWKonxRlHvPiRTU=
X-Google-Smtp-Source: AGRyM1steUx9TNawBD0U/V5zMX16ry1ElKnP2KDoRFRBDTqD6ROfZV6NA+HSpMcHvsWQ4brp9SBfuQ==
X-Received: by 2002:a05:600c:3485:b0:39c:7db5:f0f7 with SMTP id a5-20020a05600c348500b0039c7db5f0f7mr9923396wmq.8.1655466427376;
        Fri, 17 Jun 2022 04:47:07 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id h204-20020a1c21d5000000b0039c693a54ecsm6710593wmh.23.2022.06.17.04.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 04:47:06 -0700 (PDT)
Date:   Fri, 17 Jun 2022 13:47:05 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     MR <m.reichl@fivetechno.de>
Cc:     linux-rockchip@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>, heiko@sntech.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: rk3399-roc-pc does not boot
Message-ID: <YqxpuT36/sjQKm0o@Red>
References: <YqxEL/pgv3zuH6aS@Red>
 <c12cc4bd-f7b8-5e52-14a2-41a0da83bb0c@arm.com>
 <9CC86176-19B0-491F-86A4-F95E670B0A66@fivetechno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9CC86176-19B0-491F-86A4-F95E670B0A66@fivetechno.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Jun 17, 2022 at 01:43:05PM +0200, MR a écrit :
> 
> 
> Am 17. Juni 2022 11:58:03 MESZ schrieb Robin Murphy <robin.murphy@arm.com>:
> >On 2022-06-17 10:06, Corentin Labbe wrote:
> >> Hello
> >> 
> >> I try to add rk3399-roc-pc to kernelCI but this board fail to ends its boot with any kernel I try.
> >> It boot normally up to starting init but it stucks shorty after.
> >> It fail on 5.10, 5.15, 5.17, 5.18 and linux-next.
> >> When disabling CONFIG_USB, the board boots successfully.
> >> 
> >> In dmesg I see OF: graph: no port node found in /i2c@ff160000/usb-typec@22
> >> According to Documentation/devicetree/bindings/usb/fcs,fusb302.txt, the port is mandatory.
> >> Can it be possible that the problem was that the power port being disabled ?
> >
> >Indeed, I believe the OF graph error is just a meaningless annoyance, but the general problem sounds like it's probably the same thing that's come up before:
> >
> >https://lore.kernel.org/all/0ac6bbe7-6395-526d-213c-ac58a19d8673@fivetechno.de/
> >
> >Disabling CONFIG_TYPEC_FUSB302 or blacklisting the fusb302 module should help confirm that. I have no idea if it's still an open problem, or if it's been fixed and you might just need to define the proper power role in the DT; this just triggered a memory of that older thread :)
> >
> >Robin.
> 
> Yes, the issue above is still there. I therefore use dumb 5 V, 4 A USB power supplies  that do not react on the USB-C communication.
> 
> Markus

@Markus
Could you try the diff I just send ?

Thanks
