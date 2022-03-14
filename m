Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589124D8861
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbiCNPms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242645AbiCNPmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:42:44 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B373DDE6;
        Mon, 14 Mar 2022 08:41:33 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id k25so18651159iok.8;
        Mon, 14 Mar 2022 08:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rY4lnGX91BSkoxPaQ5SCRaMmjihX3PZ5V3Bm/1QXiHs=;
        b=pIap1mXobAw2rz8ZxcNEp9Z/KkzxSXkOoNrA8dW3e4PfN8pnZVO1vHfrrMoXOpXNqR
         VyaPvcPYJxir8i3XjRH6XLTmovk2/QNuvSMCBzo+MtomXW76ER/9bVufL+I6WQY3uDy3
         IwPwmkMB7rU/XbljrGbzH/KyxCaFflaBoY72FTaWcYmVs1MtXooloXb4xWLtkJt8WRLo
         YZK6wFUHmLj7zx+2oB8SpyjvVtVj2HADtSEdt6DZbbpiFCfMgEzBlEWPXvUFvtBUit+T
         RvQsmTQwM3c9lP9NMihogtfwvXUbAC2yzqOxeBQeTMOXjUU+aqnGk+TBpXxlqdilrn5d
         KS1g==
X-Gm-Message-State: AOAM53220aD9DT/+HnIdqaLyFBDKPZPi7cNRxlc4zRYhYsFXzAAptvA7
        VCpCKqwTIVBFU/HHKAA//Q==
X-Google-Smtp-Source: ABdhPJytlg8Rd17SG2Xpxxb2QPBALLGcdAVJUaxLHiJr4h8bQywp8afLDDXcpMLP4g+TKe2OqcmrJw==
X-Received: by 2002:a05:6638:35a0:b0:31a:d42:1dd with SMTP id v32-20020a05663835a000b0031a0d4201ddmr3098236jal.95.1647272492898;
        Mon, 14 Mar 2022 08:41:32 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k15-20020a92c24f000000b002c79ec214f9sm2189432ilo.30.2022.03.14.08.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 08:41:32 -0700 (PDT)
Received: (nullmailer pid 104552 invoked by uid 1000);
        Mon, 14 Mar 2022 15:41:28 -0000
Date:   Mon, 14 Mar 2022 09:41:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v6 0/6] Add sata nodes to rk356x
Message-ID: <Yi9iKBr7pPUuzg15@robh.at.kernel.org>
References: <20220311210357.222830-1-linux@fw-web.de>
 <05309a59-85cd-2434-6435-6fd956fa75d6@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05309a59-85cd-2434-6435-6fd956fa75d6@opensource.wdc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 05:00:53PM +0900, Damien Le Moal wrote:
> On 3/12/22 06:03, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> > 
> > This Series converts the binding for ahci-platform to yaml and adds
> > sata nodes to rockchip rk356x device trees.
> 
> Rob,
> 
> I saw you took patches 1, 4 and 5. What about the others ? Are you
> taking them or should I take them through the ATA tree ?

It's all dts changes, so they should go via the sub-arch trees.

Rob
