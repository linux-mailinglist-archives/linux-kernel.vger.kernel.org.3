Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0454CB0B0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbiCBVKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240887AbiCBVKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:10:10 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B5F6EB34
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:09:23 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ay10so4729478wrb.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 13:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+SuWPZ2e/7zeEhPWaoi9jelX8WbYRm2ComoX27Rv4U4=;
        b=UKsy+0FXcuJ8Do65rOR9YbcsdUErJHZHS65EmTolGTe9BMmpHY619TGTyBALKgJSQV
         /i1o2tyB9QPtreYoRnIMoLZbDG5n0xaQdAS9OuAhsn8YYqeCNQXP7+VjbkJdmFP66N1B
         z8yQfrvD57bI9vn9nkGNVFzb3IJcIPmS4qZbw4d1GxTNx9FIRRuvvcp/20Bi1hUcPcXq
         1hERbZ3B8OhnuXlZidtmDufDMZ/s0ECxo6n3cVUnCFhP16ENoYDKdc0fgbCEviNgkzHa
         B1gumXaSx6XNweFhIzz6O6zFFm5tpE7+FudcurirFwo8fw6q/vXR8emE33TcuIBitk/1
         1u4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+SuWPZ2e/7zeEhPWaoi9jelX8WbYRm2ComoX27Rv4U4=;
        b=z48KFX3KTX0EF3baqH/XCPyjIPuF8Q5KXBWVbzrImqS8n+eSXWramHUTfHx57yqjri
         H64j8NnDKGPOK6MlCSqbUtSXxLU7lS8ralXnmpmYluVu9ZbDB4yKfaB+jByjtMru91jo
         Ft7QMN4zMlW04yy97lpqp0fH1iMdRXv3vcjTB/8iz1XMBeGx0nu6wJszIiXIQzE82jk2
         3hK/5OAnYSVOzIodI64ywRUEcPK/b+DPgHiPT9mKl27mWz1ST4z511YL/F5KH7E4gKjI
         kjB49JrYik1voVJMpe1hJjvuLSYJInPFENR/StAV4Vq03lfHxEWvDf0W9fIPQXDO6j7g
         ZIYA==
X-Gm-Message-State: AOAM532MA/H7ye8j9lnJQTaa1fp/OL/TWz53qBK8kGLxrjpfNM81jezn
        F+a+ShRPzfJGsTh3BbIkdT3YMw==
X-Google-Smtp-Source: ABdhPJw1KQWknFtoCAT+qBKsppNuuDAWOhAm97zko+rTSN6HXr4brTteq/LgXKaMD610Tg1naQiAlg==
X-Received: by 2002:a05:6000:50a:b0:1e3:5af:153e with SMTP id a10-20020a056000050a00b001e305af153emr24268852wrf.385.1646255362131;
        Wed, 02 Mar 2022 13:09:22 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id j27-20020adfd21b000000b001e519f3e0d0sm118605wrh.7.2022.03.02.13.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:09:21 -0800 (PST)
Date:   Wed, 2 Mar 2022 22:09:19 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     John Keeping <john@metanate.com>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 10/16] crypto: rockchip: rework by using crypto_engine
Message-ID: <Yh/c//qzz6c20NI6@Red>
References: <20220228194037.1600509-1-clabbe@baylibre.com>
 <20220228194037.1600509-11-clabbe@baylibre.com>
 <Yh4YLGeaXAzzr+PK@donbot>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yh4YLGeaXAzzr+PK@donbot>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Mar 01, 2022 at 12:57:16PM +0000, John Keeping a écrit :
> On Mon, Feb 28, 2022 at 07:40:31PM +0000, Corentin Labbe wrote:
> > Instead of doing manual queue management, let's use the crypto/engine
> > for that.
> > In the same time, rework the requests handling to be easier to
> > understand (and fix all bugs related to them).
> > 
> > Fixes: ce0183cb6464b ("crypto: rockchip - switch to skcipher API")
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> 
> In addition to the warnings reported by the kernel test robot, this
> needs to add select CRYPTO_ENGINE to Kconfig for the Rockchip driver.
> 

Hello

Thanks for the report, I will fix this in v2

Thanks
