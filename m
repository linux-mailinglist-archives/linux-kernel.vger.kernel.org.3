Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC0948015E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 17:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbhL0QC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 11:02:26 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:35553 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbhL0QCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 11:02:23 -0500
Received: by mail-qk1-f175.google.com with SMTP id 131so14777826qkk.2;
        Mon, 27 Dec 2021 08:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=72b7qtnlhIwvuhkRbhpWgwlpCXI2ABLdzVqP9BokJ/0=;
        b=dyZkNnQbjYfoKhGDhxI6fjqcw4tMLk6IdLxTE5wBSKn7yyMa6P86laFqSuvg2ySLEh
         +959vJQhdVVRL/2tqpVX09QPdb4MRr1mGaz3DZfxiVP8HeHTl+hp/VOBFTDKtRnVt5LS
         299bPofzDFHIbkM94rad/qLPuKZJH8xxDigEit52z8NFZGFRO8BFloAtDABi/2Ow/0fJ
         Y2SDftexHmt46rY/eceGT5TsSoEneFS2Hz0eLKwVKQdfo9mkwDkk4E54L+M57eUHGcAH
         0w4yiR2VzAbiWaWpKrXAy+R0SfRqBGH00SZajKM/2xNlmJCF0Ac5X9zr4E2UQ1o6Uxmm
         x/uA==
X-Gm-Message-State: AOAM530bNtrevdJQzK3TzByf79bcodSfbpkFsWeeB0tu3ySdIAHwJD73
        2iHylc7h57aPTOvh85Z6Xw==
X-Google-Smtp-Source: ABdhPJzhUfn1ljd+iEYwyHyPKRAIZ+0Cuqt0J1Jz8ysNrIC4Q7ORN4kxEELMFLm2rG2UrLLMx6NU5A==
X-Received: by 2002:a05:620a:1a9e:: with SMTP id bl30mr12229618qkb.130.1640620942770;
        Mon, 27 Dec 2021 08:02:22 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id z5sm12613140qti.57.2021.12.27.08.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 08:02:22 -0800 (PST)
Received: (nullmailer pid 564562 invoked by uid 1000);
        Mon, 27 Dec 2021 16:02:19 -0000
Date:   Mon, 27 Dec 2021 12:02:19 -0400
From:   Rob Herring <robh@kernel.org>
To:     Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Cc:     Wells Lu <wellslutw@gmail.com>,
        "dvorkin@tibbo.com" <dvorkin@tibbo.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: pinctrl: Add dt-bindings for Sunplus
 SP7021
Message-ID: <Ycnji5pNLnA/YZbX@robh.at.kernel.org>
References: <1640331779-18277-1-git-send-email-wellslutw@gmail.com>
 <1640331779-18277-2-git-send-email-wellslutw@gmail.com>
 <1640443722.885735.363337.nullmailer@robh.at.kernel.org>
 <666ad4caaafa4090a9f3c99f56c10bc8@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <666ad4caaafa4090a9f3c99f56c10bc8@sphcmbx02.sunplus.com.tw>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 12:44:25PM +0000, Wells Lu 呂芳騰 wrote:
> Hi Rob,
> 
> Thanks a lot for review.
> 
> I ran 'make dt_binding_check' and got PASS before I submitted the dt-binding doc (yaml) file.
> 
> I found the "dtschema/dtc warnings/errors:" is resulted from lack of vendor name in "vendor-prefixes.yaml".
> 
> My colleague has submitted a patch for adding our company name to the yaml file. It was acknowledged by you but not yet committed into Linux tree.
> 
> Refer to:
> 
> On Mon, 01 Nov 2021 13:01:51 +0800, Qin Jian wrote:
> > Add vendor prefix for Sunplus Technology Co., Ltd.
> > 
> > Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> 
> Can this error be waived?

No. The patch for vendor prefix has to be applied before this one or 
we'll keep getting this error.

> When I send a new patch, should I add "vendor-prefixes.yaml"?

As it doesn't look like that series is going to make 5.17?, I can apply 
the vendor prefix patch.

Rob
