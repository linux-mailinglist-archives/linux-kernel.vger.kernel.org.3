Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FD64ED720
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbiCaJka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiCaJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:40:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57D91704A;
        Thu, 31 Mar 2022 02:38:40 -0700 (PDT)
Received: from mail-lf1-f49.google.com ([209.85.167.49]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MPXQi-1nN7XR34t8-00Mdvn; Thu, 31 Mar 2022 11:37:03 +0200
Received: by mail-lf1-f49.google.com with SMTP id d5so40435274lfj.9;
        Thu, 31 Mar 2022 02:36:50 -0700 (PDT)
X-Gm-Message-State: AOAM530XhI3aUDLE7WrTxLraYv8W2xQYM+4LWqCGYs1FijtafLVn5hjA
        A03rFeTLMRbHbCPGVj9E2emEdf1PsQiuAiCk11Q=
X-Google-Smtp-Source: ABdhPJyx6uQXMBvORHeb8NOlqEaHCi9NLjE3UiFEIE0bvdtwMjjaxo+soHSe4zhQsJUkrp9pp2oFUj5K/neYvZqbvSc=
X-Received: by 2002:adf:e54e:0:b0:205:a9be:c66e with SMTP id
 z14-20020adfe54e000000b00205a9bec66emr3326498wrm.192.1648717430754; Thu, 31
 Mar 2022 02:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648714851.git.qinjian@cqplus1.com> <fdd371ceb896ea17dde0e398a136fa9c895a521c.1648714851.git.qinjian@cqplus1.com>
In-Reply-To: <fdd371ceb896ea17dde0e398a136fa9c895a521c.1648714851.git.qinjian@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 31 Mar 2022 11:03:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0oTTLp8BB4uMMw2gdPnkMYutmrndLaQtp9g5GBom=aog@mail.gmail.com>
Message-ID: <CAK8P3a0oTTLp8BB4uMMw2gdPnkMYutmrndLaQtp9g5GBom=aog@mail.gmail.com>
Subject: Re: [PATCH v12 8/9] ARM: sunplus: Add initial support for Sunplus
 SP7021 SoC
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:F/C6lkDrYOWhZjOjlOcFkGI+hNdyGHe5L/uI/zMKgAzYNEF9ns2
 hCT0eleYvEA/CwvkTzqJS1EbMo6/rpBrXyECjqFdoKP1R8T8oS0qxescGO0m2xt9eN35G8V
 sFVQiqGxUcY3bT/qomD3WGDMuMVaqoPFgsbQ86zRv5DChzTL37cQFFl9Te71jJ5OJHznSlR
 /OQj/RKOAuCgIpsuj0oHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yJ1DIZJB1jo=:O8Y0M/XsHAkk5xWkBrq7uS
 ldVsqPu60swmOTaHXvdEd54IKSdvt6EI9wDGqs6AyrRa0K8QPPf8ub/ot1vjoQI9YRslWIHNw
 myDNj3Ztq1jFNjBcKbPOotok3YiBVF/LoFjoXk0E0k0MCleL5TFXYqepBNiuDeVNnfuv54Bfi
 hepAjDvk3A5v5CX+pdIIT79MHhvAW6qSAIEQid2N5/HVOD81qZkQgE7gMS7hNF57D74rn3Saw
 BwJyyc8/VTi09cvTK9prhhpfAPxzUUOVX2mqmEnfkaWUu69tmYvpIt06daUyjtPuzZzINZQPq
 bCh384f6Gy6jafXzHvOmgmt/fU04VElSGFwQJfpCsADpGhZhaTg6Lj86lPwWr9R4cjxIs67lr
 EBTTT88qhD2D5nBhMGm4H6MtVIEStzyEerdtKEOUUbEWDLB6CPH7J+0NdwOOs1upC5Sn50vgY
 Lk+Q9EHzrSryLaJ3gjdbtb5jxWqSob+eqJ02AK/PTTJePyIAhTs6sKR4Cr6paK/TjRj8Es5UX
 WBbsjw9MmaIyP0ssD9Jar4trKG2X8ZilWXWUx1zAH3qNg8mGeD5uEKJQD++EKFKqLyptCP4KV
 Hz9XtasvVRYTXgynYznzogeuwR2XkIkKBBvFLwjIgzJ/wQJ5Q+UzDhNLM+mImvqaWJiydFPTI
 M6Og1+X2IOiOFowgnkXCd3mJ2glfkYYCSUFOqBfRi7D8mcgBNzP/7BZh7TPJlPEkiC2fYIFPL
 hRVHYpR8Ecj7YoP9Tc/tYp5kFmKWllbwb6d7J8DESM7HIqgRL+mlAxp6QKPD1kq8pApOkaxai
 uIzRg3wZufucHKH3Zxoh2n7YPICaxwdRZR9F/jJCEkF7/IVE3LFjw4WKMoas1wms/TSejhWnE
 VLpERja1lJxA+qTrk5jnEBQTeuAgwr/2SV231PKfpIQrTGzSYF66fsT0mjrM/Kjd4LRL2EA+e
 QH9sXrstyFhHFaonAxLdwakNi7dJjnAE5padaFjzltk2FpGl2jaBUbk5WA+TiETbla83o5EqG
 KD9xYRvy/c/bxZz5/BwpzjuukAN7MyEELFzy9oUj8lSInnMKjhw8C5y4f8k/DNsdfTxd8t3Yj
 vSAU1/JoO7CqdejT9elARFDHSaCc8U2FEoO5inAa9xsMWt06WTauMKmRaAKLRb8FOi4buOVjo
 FOMXExDZyTJyxzR1M8fmhTFTJNpzsxIbSsLJRBRG49iE9ltddKKFwBKFmliO6fc25pwClOfB7
 5BRNz/0JCTMD1ubNL
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 10:29 AM Qin Jian <qinjian@cqplus1.com> wrote:
>
> This patch aims to add an initial support for Sunplus SP7021 SoC.
>
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>


Reviewed-by: Arnd Bergmann <arnd@arndb.de>
