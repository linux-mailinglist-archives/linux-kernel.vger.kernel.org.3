Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1635B4CAE38
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244913AbiCBTF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiCBTFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:05:51 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7927D04B4;
        Wed,  2 Mar 2022 11:05:07 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id e15so1158166pfv.11;
        Wed, 02 Mar 2022 11:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1v/GWH828oM9qnw7BmuwPl1OTwbK6th2t0rZuoggB/w=;
        b=ZhyXOK3wtbHda6wuUihJ05V5rG7u73YYPzNG2P3Rqn46fkvYe+zsehpnNA3JLoYVNQ
         omuYRrc8bolqhZsCwYCJ00BtBwMy6eO8vebHuG2yJgjmkfx7YK+t7bcFYMBo9MB/CJrA
         ysj4wSTfCSnNa4hzgbKXWC0roQiVIvleSeh9CwqPJxL2EQ4pUeJRddoqYd6fTRoC1OTE
         gLKk9K+BMcou31589beb+DxDz7Zx/W2dBBw/NFmeqL9SlKNqr8tRGnrNymWMu9i6V0hk
         UZd/DBdSwEcJ5Z54tJSA/SzbtKz1n0P1bMlXCXV7OMNwso3UlcDzB6JrpSaUwcrN93IR
         U2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1v/GWH828oM9qnw7BmuwPl1OTwbK6th2t0rZuoggB/w=;
        b=qTGq+9VisaDAvUnvhpulTfun7sW9I/5nxX7fgJiBCJdmIzSd8qCNFGUMEvSl7R4IW+
         c33eciRK1KWq3peSQLu+yxJztZ/Xk1LEpHirPxjNPmtPs4ztdMA8CGA1PRLqwN06tpnD
         HwFAT5qEfqIKAuoBTnucyMaDu/IgZLYCtajcxPdCWrBM8FAH1AmyPi/sWHHN0EIYYSI6
         zU05ow2VjsXwFYoQluosGDTrC32cwg8oMbCoYrciW1CPH2Q+VNQELIZpUPw66PMCzi0o
         kdNBt4tWTc/maIKZZBJYcT/jCTc3WmMysfbQi4p7z1hI8sifCSO5xrpj5TTnd+QnOP1h
         +Qjg==
X-Gm-Message-State: AOAM532D+j9ncliCDVGOLa6mVZnoJhsaFyS9zzUnu7h6NKMvBeJDSCiT
        xeGP0wm1GO8fVB/esAfowmgtGtKm+AT6OQ==
X-Google-Smtp-Source: ABdhPJzpPlIv5KYqzsr/vWUHpTcqLEynLR/AoOHj/8TEInuNwABg/YDvtIwl/rkIspDh3TNNwwGSxA==
X-Received: by 2002:a05:6a00:21cd:b0:4e1:b09b:18e8 with SMTP id t13-20020a056a0021cd00b004e1b09b18e8mr34456075pfj.60.1646247907314;
        Wed, 02 Mar 2022 11:05:07 -0800 (PST)
Received: from 9a2d8922b8f1 ([122.161.53.154])
        by smtp.gmail.com with ESMTPSA id n42-20020a056a000d6a00b004e1a01dcc35sm21486049pfv.150.2022.03.02.11.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:05:06 -0800 (PST)
Date:   Thu, 3 Mar 2022 00:35:01 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/3] dt-bindings: spi: Add spiclk to clock-names property
 in pl022
Message-ID: <20220302190501.GA2168@9a2d8922b8f1>
References: <20220228124345.99474-1-singh.kuldeep87k@gmail.com>
 <20220228124345.99474-4-singh.kuldeep87k@gmail.com>
 <f22e9ddc-3103-2785-5504-fcc95d08cc8b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f22e9ddc-3103-2785-5504-fcc95d08cc8b@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 02:36:23PM +0000, Robin Murphy wrote:
> On 2022-02-28 12:43, Kuldeep Singh wrote:
> > Fix below dtc warning by making necessary addition of "spiclk" in
> > clock-names property.
> > 
> > arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dt.yaml: spi@190000:
> > clock-names:0: 'spiclk' is not one of ['SSPCLK', 'sspclk']
> >      From schema: Documentation/devicetree/bindings/spi/spi-pl022.yaml
> > arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dt.yaml: spi@66190000:
> > clock-names:0: 'spiclk' is not one of ['SSPCLK', 'sspclk']
> >      From schema: Documentation/devicetree/bindings/spi/spi-pl022.yaml
> 
> As before, what makes the binding at fault rather than that DT? The PL022's
> actual input is named SSPCLK, not SPICLK, so why should a driver which wants
> to look up that clock by name expect to look for "spiclk"?
 
That's right. It's the DT which is at the fault of defining spiclk
instead of sspclk and need to be fixed in DT itself. I didn't take a
look at pl022 doc and acted on the basis of DT info.

Moreover, DT also uses sspclk and SSPCLK names interchangeably which are
anyway same. This also require updation to follow single convention.

Appreciate your comments and valuable inputs.

-- 
Best Regards
Kuldeep
