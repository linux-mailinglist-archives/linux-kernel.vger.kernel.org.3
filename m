Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E1F5A6BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiH3SEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiH3SDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:03:49 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963FC43331;
        Tue, 30 Aug 2022 11:03:43 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 92-20020a9d0be5000000b0063946111607so8602382oth.10;
        Tue, 30 Aug 2022 11:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=E/aVLvibqd/b36Ng45UDa0e8w5QaN31zCJl6Jumumq4=;
        b=YNY3jcrx5+y8HwLX2rbz4bbAZxMEj08Fb+WZRTAYZM/+vl4LJ0Y6rKIAQutaraXHAy
         vXkqdUGNhnju/LJhd87InIDFvoUbX0YbDlCqiDI1chDFmK3fD7pcOnO8qrBpKcPWdVl3
         f3eyt1G0RF+AJfKk7PZUP6xzbbwlkVyaPQJnyqwx+GCmLHfOpHQ0VWvLQIAY5ZhC6iUV
         F9xQNNz4897w6PPq5Qkjru5s8MaUBQWl/kEHTR3tepbYtQuXCNdz8E0KhNLu3ujhS2fN
         wpbuczsuxWOWg8jDvwmAIPmxdp05P+9ZU98gPn8vh2TfW1N6ydCneROFROhLKy7td1eC
         WHhA==
X-Gm-Message-State: ACgBeo1EUh/hYlwsvyXJdloKcCWqBP0SxScTlDUvaZgXxAq2+z5+qI+1
        IYyM1v7ks3aQUvn+CrAcqg==
X-Google-Smtp-Source: AA6agR5JGLNMerqnzMNRFokwD0kYQMtWsTMxX51+yE5oIJHMl04sDutLbVBGC7lLaqgSJK5sj75chQ==
X-Received: by 2002:a9d:72d0:0:b0:638:e9cf:3e75 with SMTP id d16-20020a9d72d0000000b00638e9cf3e75mr8732407otk.289.1661882622846;
        Tue, 30 Aug 2022 11:03:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x19-20020a9d6293000000b00616dfd2c859sm7579226otk.59.2022.08.30.11.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:03:42 -0700 (PDT)
Received: (nullmailer pid 1769934 invoked by uid 1000);
        Tue, 30 Aug 2022 18:03:41 -0000
Date:   Tue, 30 Aug 2022 13:03:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Guo Ren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        qemu-riscv@nongnu.org, Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, Sagar Kadam <sagar.kadam@sifive.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: riscv: add new riscv,isa strings for
 emulators
Message-ID: <20220830180341.GA1769896-robh@kernel.org>
References: <20220823183319.3314940-1-mail@conchuod.ie>
 <20220823183319.3314940-4-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823183319.3314940-4-mail@conchuod.ie>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 19:33:19 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The QEMU virt and spike machines currently export a riscv,isa string of
> "rv64imafdcsuh",
> 
> While the RISC-V foundation has been ratifying a bunch of extenstions
> etc, the kernel has remained relatively static with what hardware is
> supported - but the same is not true of QEMU. Using the virt machine
> and running dt-validate on the dumped dtb fails, partly due to the
> unexpected isa string.
> 
> Rather than enumerate the many many possbilities, change the pattern
> to a regex, with the following assumptions:
> - ima are required
> - the single letter order is fixed & we don't care about things that
>   can't even do "ima"
> - the standard multi letter extensions are all in a "_z<foo>" format
>   where the first letter of <foo> is a valid single letter extension
> - _s & _h are used for supervisor and hyper visor extensions
> - convention says that after the first two chars, a standard multi
>   letter extension name could be an english word (ifencei anyone?) so
>   it's not worth restricting the charset
> - as the above is just convention, don't apply any charset restrictions
>   to reduce future churn
> - vendor ISA extensions begind with _x and have no charset restrictions
> - we don't care about an e extension from an OS pov
> - that attempting to validate the contents of the multiletter extensions
>   with dt-validate beyond the formatting is a futile, massively verbose
>   or unwieldy exercise at best
> 
> The following limitations also apply:
> - multi letter extension ordering is not enforced. dt-schema does not
>   appear to allow for named match groups, so the resulting regex would
>   be even more of a headache
> - ditto for the numbered extensions
> 
> Finally, add me as a maintainer of the binding so that when it breaks
> in the future, I can be held responsible!
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Link: https://lore.kernel.org/linux-riscv/20220803170552.GA2250266-robh@kernel.org/
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Acked-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Palmer, feel free to drop the maintainer addition. I just mostly want
> to clean up my own mess on this when they decide to ratify more
> extensions & this comes back up again.
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
