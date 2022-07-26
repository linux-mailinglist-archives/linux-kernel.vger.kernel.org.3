Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFDB5810BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbiGZKE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiGZKE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:04:56 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2822631DF9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:04:55 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id jw17so605159pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MARNitJXpUp5V5BqpBLjV9YJ/Pj5d0FSUQXbA2ZWy9s=;
        b=Bjms2BIL/r5q0wlImvQaJVgGSYwlBJEzjGedddfY7ujHmeDYCbYQH8q+Bd8CjPTThq
         Xhwh1Dwh+q8pEHYJ8a5tYFNbtbBaReuTMtx4/dAkjtHluHvcRlvpxXln00zfRmJG/ovw
         Kn3zZqBGi2LNyOuiNZ22qTHu6PFrpAz0+Vu/l0kL7ysE0z7tzvs/LKNjUlrHkM0wMRus
         VrJvi8OfOkYPdcmbg1qVuVNFcsfjK8efxKFOOfjBqQ7B0ySJPndjDhUuIlvujYA8ApWO
         tOAZjtio1vEWAzqVpEW35VDaZ0pQeD8IAVW5cTRekbU6/aS9VchnK0LvitGvxzhfDqxL
         xHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MARNitJXpUp5V5BqpBLjV9YJ/Pj5d0FSUQXbA2ZWy9s=;
        b=Y5Z6jCZZvtCmltTCyJoe60GGwQw37AG0Fh3Xtl0nr68hyJMIVu3l4K10hsxrMdsCpL
         xSx5QiY14z9RgJzLf/uVv5no6EkRGHw51ojGkWUGZaBLpdQssUxxk9tGxkEuJY/TqrlT
         VGkeSo4g6i1lpkVKIFGJ/HvbZi1cVCMlcXjTJhBSiuAuBkj7lB7XJ6yMATgJAaysvWcW
         hq9ixRDN9x7z298t4KezXY4kRN/sC+CXNn8c55V1SOdnhRykwc+pRpUxAo8XXCqTdCcG
         pz6Oiwva/UOqqkWkqol9oIA7Ptfu1FsmuToGp2fHaAHRJ5sbAdDc+OJ/Aj0r2bZ0zvTg
         dfqw==
X-Gm-Message-State: AJIora/04fajnwc2M5ebzVwv2V5Wqx+v2vE518iOS3l06+bKXGaXHdzK
        SsR1Qeucx0I6kO298KNBJZ0=
X-Google-Smtp-Source: AGRyM1st2n7Fokw/bin1aNCoebxGddLsDbdZIiVPrvb94cWGdXRY/ZNxQtQzGIamm/LeM69ZrQtfow==
X-Received: by 2002:a17:902:db04:b0:16d:82e7:72c2 with SMTP id m4-20020a170902db0400b0016d82e772c2mr6762400plx.100.1658829894601;
        Tue, 26 Jul 2022 03:04:54 -0700 (PDT)
Received: from [192.168.0.10] (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79408000000b00527dba9e37bsm11254510pfo.73.2022.07.26.03.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 03:04:54 -0700 (PDT)
Message-ID: <87d956a8-ef14-6556-1cc9-eb2be735501a@gmail.com>
Date:   Tue, 26 Jul 2022 19:04:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/6] mtd: spi-nor: sysfs: hide manufacturer if it is not
 set
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20220513133520.3945820-1-michael@walle.cc>
 <20220513133520.3945820-3-michael@walle.cc>
From:   Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <20220513133520.3945820-3-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/2022 10:35 PM, Michael Walle wrote:
> The manufacturer may be optional when pure SFDP flashes are supported.
> Hide the sysfs property if no manufacturer is set.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Best Regards,
Takahiro

