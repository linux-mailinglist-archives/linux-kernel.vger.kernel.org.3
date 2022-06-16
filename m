Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1676B54E539
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377350AbiFPOn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376397AbiFPOny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:43:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3610946664;
        Thu, 16 Jun 2022 07:43:48 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h5so2211450wrb.0;
        Thu, 16 Jun 2022 07:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=985lyW+ymSN+1KX2wglPXmPrHIwR1ZNAwGozRXF+cAk=;
        b=H+MqRqIcYZJGl+fIARvDt5E+nl599ga3oyDbMLBBisOxfq/SyTCwZG0Klyezq1+CUW
         sefLQD2EeMqxqaJrfnrkNrFZhVikdu4wMrtck74oCiEmuEgiYmtNpsRIF1tZqnrkF5Mx
         NZkApEMPJNl/kDFEI1hA+Ue/R0aw1W8KZMZoedgEZYkf3svTuJogxbSWKM4crDZGxinQ
         0wFVmmTIUPwII1349fc94HNyry9a7jLBlghobSH5Kq06AzNFkA5kw6DqqFRMJMjCCq55
         jezPkDIchFIXBzf+CG7v9iTSodSWY9/lo0HS0xX3CZ2o6npEv7M2DG1DnlMLEQXeesqV
         hW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=985lyW+ymSN+1KX2wglPXmPrHIwR1ZNAwGozRXF+cAk=;
        b=iFXCXMsNk7G1ck5HtbLgMLiVZ6NfLyL5LayzuruownmfUyu143bIE8gSIUP7ChSq/x
         F8kjWczzhHhI+8X65HlC5tu8CKgZfoqpop2aJlJFSuNz2GGBuSv0VwWZ5cw6/XJ2BLRo
         mIhduuAWcx6T1Qpr2dKGTzVbwcTjAlq2ynEsUphtNxRTNJSE+AMX+J6u4NRcuv4zIVn4
         aZ2MV/GmPKgJJvufgwOPDvjUSoUQ1A4DrU407ZlTqHJ+FBX0LVtAjT+LBWBNAVnC0nF/
         z8+yMa8Gm+PzVBLqAt/9FrCXzM9UwIS1x42D6LXzZpb/kwzae5Rb/wWo4MyntBURNziK
         sAyQ==
X-Gm-Message-State: AJIora8QyMRkwtZJM3P4Agrq5nS8VjeLRMuqpuPT4RZW/zfCEQnnPkPS
        17ibUCbWIy5mZf0iPo+X48I=
X-Google-Smtp-Source: AGRyM1tajG3QG7/QWFCxjmxsAuXLSZv0+YuL9rwSS06bBr1D9gFyr74sDvu5dLu6L6z7sAmN/X6eBg==
X-Received: by 2002:a05:6000:186f:b0:213:4ece:4086 with SMTP id d15-20020a056000186f00b002134ece4086mr5104454wri.438.1655390626594;
        Thu, 16 Jun 2022 07:43:46 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c4f1000b003942a244f40sm6815826wmq.25.2022.06.16.07.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 07:43:46 -0700 (PDT)
Message-ID: <62ab41a2.1c69fb81.aa33.ca40@mx.google.com>
X-Google-Original-Message-ID: <YqtAplHcHm4Copoe@Ansuel-xps.>
Date:   Thu, 16 Jun 2022 16:39:34 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] mtd: nand: raw: qcom_nandc: reorder
 qcom_nand_host struct
References: <20220615000612.3119-1-ansuelsmth@gmail.com>
 <20220615000612.3119-2-ansuelsmth@gmail.com>
 <20220615171132.GA3606@thinkpad>
 <62aa76ad.1c69fb81.7e2d3.0c8e@mx.google.com>
 <20220616163751.2b5962df@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616163751.2b5962df@xps-13>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 04:37:51PM +0200, Miquel Raynal wrote:
> Hi Ansuel/Christian,
> 
> ansuelsmth@gmail.com wrote on Thu, 16 Jun 2022 02:18:08 +0200:
> 
> > On Wed, Jun 15, 2022 at 10:41:32PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Jun 15, 2022 at 02:06:10AM +0200, Ansuel Smith wrote:  
> > > > Reorder structs in nandc driver to save holes.
> > > > 
> > > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>  
> > > 
> > > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > > 
> > > Thanks,
> > > Mani
> > >  
> > 
> > I'm sending v8 with a different Sob so I'm not adding the review tag (in
> > v8).
> > In short the new Sob is what I will use onwards, wanted to keep the
> > Ansuel reference but it was suggested to use Christian Marangi and
> > nothing more. It's just a name change and we are the same person and
> > nobody is stealing ownership of the patch.
> > Sorry for the mess.
> 
> Mmmh strange, but okay. You are supposed to contribute with your real
> identity, not under pseudonym anyway.
>

You are right, it's something I'm trying to fix... Fact is that the
original series was old so I didn't want to change the name.

> Also, you could have kept Mani's R-by in v8 but anyway. Mani, can
> you resend them?
> 

Didn't want to make changes to the patch with the R-by tag just to make
sure. Better safe than sorry.

> Thanks,
> Miquèl

-- 
	Ansuel
