Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622374DD028
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiCQV1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiCQV1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:27:44 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B30E127E;
        Thu, 17 Mar 2022 14:26:26 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so6640850pjp.3;
        Thu, 17 Mar 2022 14:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O28KFB9Z1FTz+AymH1IN8bgHj7fL/zlAB/PUyRZgUJs=;
        b=p46uwofeLg5Vu8lhhImWBLOdalf9R9c51tbeP4ZqSXmJbVrnjwLKBmGO9x6y741/9C
         F1z3FT9GcfO3w8Uy5wgXkvY6Zwo2xF4zgYMtDHHrA2e3Tsx6H8wPajgjqunwWno7+obU
         O6jsg/z1Bm5Zqn45iBnmqEX6OA1XWo7u0lsPGuH6iRhhTvHzeE2ZhCcy8SVHLf76esom
         jC4E5SjBuceJocPckCw5BIzd3ZvDCUpxHgkpX8+G+QJVoz3BlD1LcuU1moF9RfTaOcXO
         EkObbZW7qdIyoS1dWuTav1xwouqRxh6yOZ1vBaCw4wPeTtMpIuOCslctpNdt1fGceRqP
         Q0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O28KFB9Z1FTz+AymH1IN8bgHj7fL/zlAB/PUyRZgUJs=;
        b=1Zbw8PbbMsfRlZbFZJYq30NNsPA1/xsrHRAijo3POLNEeakSr29lEu+lTQyEquU72d
         l6aAwgnBjDdHWcVS/zOyUk2BK7Fu8+IORtKCHLISRZM04rNjN0MOylKFr7Cv+8HDpPXp
         Z3CsDCz9yyr5iENVabZjjdfUY00/BwC4C7o5XBymhs1asQPAjgXG4qzqKSi4usc3QGgf
         eqatnONAdxukug2UCL21408S8tFQMSS//vk9o2WzivxeFINi9ApulD+kAGLS+r71mJOh
         dqkicxyiOA4Tx8B96ykzgk3McYNuvLd2D7kEFAowiUWrPccxkjEDRbGNW3FqBJneIg3p
         ykYA==
X-Gm-Message-State: AOAM532r1jwS82VZxbd6Rnx8zt5XQMehQcEQokR2AxgUCxLdI66pZcK3
        ikIl1Xa5inExEDdx6jJkykw=
X-Google-Smtp-Source: ABdhPJwiI+1DF6j6F1CN5z+IyxD3suUX3qc9ceGaxuETSEpJcT/76Ll3c9nj5XiMyX7kuDZiR4jblg==
X-Received: by 2002:a17:90b:3e8c:b0:1bf:4043:daa with SMTP id rj12-20020a17090b3e8c00b001bf40430daamr7630460pjb.233.1647552315163;
        Thu, 17 Mar 2022 14:25:15 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id k185-20020a6384c2000000b003821dcd9020sm1284016pgd.27.2022.03.17.14.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 14:25:14 -0700 (PDT)
Date:   Fri, 18 Mar 2022 02:55:08 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: timer: Document arm, cortex-a7-timer
 in arch timer
Message-ID: <20220317212508.GB99538@9a2d8922b8f1>
References: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
 <20220317191527.96237-3-singh.kuldeep87k@gmail.com>
 <558f0c92-c499-daca-e1ad-2b16137f8c06@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <558f0c92-c499-daca-e1ad-2b16137f8c06@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 08:25:12PM +0000, Robin Murphy wrote:
> On 2022-03-17 19:15, Kuldeep Singh wrote:
> > Renesas RZ/N1D platform uses compatible "arm,cortex-a7-timer" in
> > conjugation with "arm,armv7-timer". Since, initial entry is not
> > documented, it start raising dtbs_check warnings.
> > 
> > ['arm,cortex-a7-timer', 'arm,armv7-timer'] is too long
> > 'arm,cortex-a7-timer' is not one of ['arm,armv7-timer', 'arm,armv8-timer']
> > 'arm,cortex-a7-timer' is not one of ['arm,cortex-a15-timer']
> > 
> > Document this compatible to address it. The motivation to add this
> > change is taken from an already existing entry "arm,cortex-a15-timer".
> > Please note, this will not hurt any arch timer users.
> 
> Eh, if it's never been documented or supported, I say just get rid of it.
> The arch timer interface is by definition part of a CPU, and we can tell
> what the CPU is by reading its ID registers. Indeed that's how the driver
> handles the non-zero number of CPU-specific errata that already exist - we
> don't need compatibles for that.
> 
> In some ways it might have been nice to have *SoC-specific* compatibles
> given the difficulty some integrators seem to have had in wiring up a stable
> count *to* the interface, but it's not like they could be magically added to
> already-deployed DTs after a bug is discovered, and nor could we have
> mandated them from day 1 just in case and subsequently maintained a binding
> that is just an ever-growing list of every SoC. Oh well.

Robin, A similar discussion was already done on v1 thread. Please see
below for details:
https://lore.kernel.org/linux-devicetree/20220317065925.GA9158@9a2d8922b8f1/
https://lore.kernel.org/linux-devicetree/726bde76-d792-febf-d364-6eedeb748c3b@canonical.com/

And final outcome of discussion turns out to add this compatible string.

I see people with different set of perspective in regard to whether keep
compatible string or not. We should have some sort of evidences to
support claims so that next time when similar situation arises, we'll be
aware beforehand how to proceed.

- Kuldeep
> 
> Robin.
> 
> > Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> > ---
> >   Documentation/devicetree/bindings/timer/arm,arch_timer.yaml | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
> > index ba2910f0a7b2..ea390e5df71d 100644
> > --- a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
> > +++ b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
> > @@ -26,6 +26,7 @@ properties:
> >             - arm,armv8-timer
> >         - items:
> >             - enum:
> > +              - arm,cortex-a7-timer
> >                 - arm,cortex-a15-timer
> >             - const: arm,armv7-timer
