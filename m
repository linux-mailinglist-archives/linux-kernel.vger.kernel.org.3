Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1656D4DB786
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244998AbiCPRo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbiCPRo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:44:27 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B8813F2D;
        Wed, 16 Mar 2022 10:43:13 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w4so2369787ply.13;
        Wed, 16 Mar 2022 10:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ffIAIQFc2cAlKifnXo9kBri/p18XrYzz9Wn/ebkpe2Y=;
        b=oRaai7D6WoTdn09DUthJ/tCt3ZRRRmTzMA9X8s8oBmeJAg4xuhj7WSnLzfEEhEgo2q
         DPQt68VNB+OVBXGlLhiEMHEqhRgGOQ6FznYvsQO3pSP3mKq2fQbVYApDCLtvu+m6TXub
         OQ3gOjdeLx4Ju83hgwuQrZ1VX6sKiMYMOix6Gt9suK2mEtycc+nIg765JAyisOEJLIl9
         cFPvtIgB5mIdKc8h9FYLeJ9OXBGUuLxmMkRZX6oz/Os2hvWArKKuLNgOXg9KDXlOm1Hv
         j5WeXFkxP3L83WDfWIsCvjRR3+oZ/byvxYBspjIXAtF0fidfuwVcLlwf32PaEEogdmtY
         hHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ffIAIQFc2cAlKifnXo9kBri/p18XrYzz9Wn/ebkpe2Y=;
        b=bUTlq2qWgter4K7m7YKPb++WjFUnlIELAn8BN79zxOzWXj3X1HJOUT6HwlAJrKGYE3
         vKtoHu3Fg8hma91GCn199qwUSngrrvk502JahajWDjsNXELY+VHzySrupmRDW4sNEFun
         sqb6WaJLmukLQvdSHEiD643iOUN61ehptgWiBfAh6B+gyQ+jSc5WGBFOP2iIjYACmrSC
         ANyScmCHxeLzrZoLf1705+1RkpqYjvbymMHIoKx7RLFjg9qXRt7CoQpk57E2H+AfNXtB
         VVYdTOInMtB3EPeDUto5OTmfV79ZeXg92cRs4hAJ+ld6rerNTHICzaxmiMJsJo4zr1IB
         XIyw==
X-Gm-Message-State: AOAM532M3lKDXlCZDyDFFJT6o2BCsLqFeBbERg9pcWgfK3JcaKPbb06u
        5VSMt08iCXtt8UC0ObhhNAU=
X-Google-Smtp-Source: ABdhPJyQXcnhJGX4GLSkway+M5F+Uzq+ULmdDX4acrkkN+dZx1VsMPBvO0zpceH6za8lhtXP6hIjJA==
X-Received: by 2002:a17:902:a40d:b0:153:7213:1584 with SMTP id p13-20020a170902a40d00b0015372131584mr778008plq.56.1647452592648;
        Wed, 16 Mar 2022 10:43:12 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id n18-20020a628f12000000b004f743724c75sm3777905pfd.53.2022.03.16.10.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 10:43:12 -0700 (PDT)
Date:   Wed, 16 Mar 2022 23:13:06 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: timer: Document arm,cortex-a7-timer for
 arch timer
Message-ID: <20220316174306.GC21737@9a2d8922b8f1>
References: <20220316095433.20225-1-singh.kuldeep87k@gmail.com>
 <20220316095433.20225-3-singh.kuldeep87k@gmail.com>
 <662981fe-7cf4-b0e6-2d43-3f33a53a6abd@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662981fe-7cf4-b0e6-2d43-3f33a53a6abd@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 05:28:49PM +0100, Krzysztof Kozlowski wrote:
> On 16/03/2022 10:54, Kuldeep Singh wrote:
> > Renesas RZ/N1D platform uses compatible "arm,cortex-a7-timer" in
> > conjugation with "arm,armv7-timer". Since, initial entry is not
> > documented, it start raising dtbs_check warnings.
> > 
> > ['arm,cortex-a7-timer', 'arm,armv7-timer'] is too long
> > 'arm,cortex-a7-timer' is not one of ['arm,armv7-timer', 'arm,armv8-timer']
> > 'arm,cortex-a7-timer' is not one of ['arm,cortex-a15-timer']
> > 
> > In general, removing an existing entry is mostly devastating considering
> > backward compatibility. Therefore, document it.
> 
> How removing undocumented and unused compatible is devastating for
> backwards compatibility? I don't see it.
> 
> DTS is rather wrong, not bindings. Otherwise please explain it more, why
> DTS is correct.

Please see my comment on 3/3 patch.

- Kuldeep
