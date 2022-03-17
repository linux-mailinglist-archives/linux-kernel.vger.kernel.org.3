Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BFB4DCFF2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiCQVLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiCQVLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:11:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611E6FDE3F;
        Thu, 17 Mar 2022 14:10:30 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id z3so5481366plg.8;
        Thu, 17 Mar 2022 14:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5119qc3EtEQdDi8mG4lL3e8ynwtRHGtpJfUH9ad79BM=;
        b=cLbT42cpQNWZwjJlG1HnfdtUY2sEaO3MFC70NXE52i6GLZibAK6Lc+lPwcNb8Ix9pl
         KERlUCP/9Nu8tzePGfDRvKLgtyQpV9zbLKOP3MmzlIBK9OaRMaBz31mVX/VzB0K4+nEQ
         nvXspkRLxRJg5R3ZB2ih+tf0A9N34hPWap1kgA99fyVmUNOK/X7LkBFR81em8dCeb0om
         sdTaSTkk+0RIHwCQ7IDD3jDo4xa86MYRSCSwbYhAp2QWnirLfqKmhEgmwpa80PDQBZRl
         FjpOb12nlrmX0h9IV+bjY6i6u4jq69yZDk3XP4+M3sHvjwIcNg7KcB5b5zs1ukiJ5IVf
         tXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5119qc3EtEQdDi8mG4lL3e8ynwtRHGtpJfUH9ad79BM=;
        b=OmWw7R2rWGKffukMTY1LJMV3WbIh2CIC7o8IiIcKEYik+5oAp7ZpU4t7VGGIqK2OXC
         KIDyQmIxdn+6KtCCNyxL01Jn2jcQu0jQFdJ2c8vZb+xAxiuFUtnJISH28ze0DgM+bEW1
         NwYtytOmUraEdJSguZ3F1CyttOOFJQJcbR31cyFk9QHkLy46l0MhDJfiwBL08ytVrX6h
         YiToJBOl/5HkOcESDi8i2GQBVmYi/5+tVRM+3kxBPPMV0TV2Rtf60/evhgFhlPibLyCN
         5pvgSbv5qCktX5YFaYjw8xjZf4KiPseVKFPrQOaCZHF7WuT8qizKEL/ICE8AesXrp1Sb
         CEsg==
X-Gm-Message-State: AOAM5301YJOuKCQPGKKfFxRCgVW7jWg4E3o9t1fAF+/Xn51fRD8tO9Kg
        Ch6TimgoZq01Q8NbExKZ/17HFKrGreU=
X-Google-Smtp-Source: ABdhPJxXmdglkWtd/gJOeOPGrLtSGqZac2mfJTMtH5m81DtDv/2NIUQ7qhi00BvFz4PDEuRQCWqbZA==
X-Received: by 2002:a17:90b:2242:b0:1c6:80e3:71b6 with SMTP id hk2-20020a17090b224200b001c680e371b6mr6024596pjb.152.1647551429768;
        Thu, 17 Mar 2022 14:10:29 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm10187305pjc.56.2022.03.17.14.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 14:10:29 -0700 (PDT)
Date:   Fri, 18 Mar 2022 02:40:24 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v2 3/3] ARM: dts: aspeed: Remove arch timer clocks
 property
Message-ID: <20220317211024.GA99538@9a2d8922b8f1>
References: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
 <20220317191527.96237-4-singh.kuldeep87k@gmail.com>
 <87h77wxslh.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h77wxslh.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 07:54:34PM +0000, Marc Zyngier wrote:
> On Thu, 17 Mar 2022 19:15:26 +0000,
> Kuldeep Singh <singh.kuldeep87k@gmail.com> wrote:
> > 
> > Arch timer either require clock-frequency property or doesn't need to
> > specify clock at all in DT. In general, frequency can be determined
> > internally and in case of brokern firmwares, need to extend
> > clock-frequency to pass info to driver.
> 
> A clock frequency and a clock are not the same thing.

Yes Marc, That's what I have mentioned in commit description.

Driver uses "clock-frequency" property only and doesn't take inputs from
"clocks" property. So, any platform should refrain from defining such
entity at first place in DT. Binding also says the same i.e pass info
via "clock-frequency" property and no mention of "clocks".

> 
> > 
> > Aspeed BMC is the platform which defines clocks property, an invalid
> > entry which can be safely removed.
> 
> Safely removed? Says who? Have you tested this change?

Since "clocks" is never read by driver and driver incorporates
"clock-frequency" which was certainly not defined here, I believe this
reasoning is sufficient for my clause. As it's safe to remove an entry
which was never used.

Please note, it's just Aspeed BMC which had "clocks" defined, other
platforms which require input from DT have extended "clock-frequency"
property like I mentioned before.

I don't possess this platform physically,and did successfull compile
time testing. I have initally copied few Aspeed folks, they can help in
reviewing and confirming this.

> 
> > 
> > Moreover, clocks also matches incorrectly with the regex pattern.
> > Remove this entry altogether to fix it.
> > 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> NAK. That's not a reason to randomly butcher things.

I hope I explained my reasons above.

- Kuldeep
