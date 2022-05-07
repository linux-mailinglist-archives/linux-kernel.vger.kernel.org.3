Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BF751EA80
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 00:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242820AbiEGWYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 18:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiEGWYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 18:24:08 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A76D1FA73;
        Sat,  7 May 2022 15:20:20 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 628023F617;
        Sun,  8 May 2022 00:20:13 +0200 (CEST)
Date:   Sun, 8 May 2022 00:20:11 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     phone-devel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: leds: qcom-lpg: Add compatible for
 PM660L LPG block
Message-ID: <20220507222011.qynqs5onwbptu2ky@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Pavel Machek <pavel@ucw.cz>, phone-devel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220504205704.699500-1-marijn.suijten@somainline.org>
 <20220507211907.GF11004@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507211907.GF11004@duo.ucw.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel!

On 2022-05-07 23:19:07, Pavel Machek wrote:
> Hi!
> 
> > Document the availability of an LPG configuration for the PM660L PMIC in
> > the Qualcomm Light Pulse Generator driver.
> 
> Thank you, but I could not apply it.

Thank you for notifying me.  It seems the diff-context changed a little
when the pm8350c-pwm patches were applied, the series is now rebased on
linux-leds and re-sent as [1] (I may have forgotten to pass -v2 to git
format-patch, apologies for that).

[1]: https://lore.kernel.org/linux-leds/20220507221123.2201668-4-marijn.suijten@somainline.org/T/#u

> Can you collect reviews

Unless I missed something there only seems to be one Acked-by from Rob,
on the dt-bindings patch - I hope that's enough and otherwise Bjorn may
want to chime in on the LPG code part.

> I'll only be able to apply first two.

No worries about that, I expect Bjorn to pick up the latter two through
the arm-msm tree.  Is it okay if I send all patches as a unified series
going forward, or should it rather be split per sub-tree/maintainer?

Last but not least, a friendly reminder to look at patch [2] (resent as
[3]) to complement Bjorn's LPG patches.

[2]: https://lore.kernel.org/linux-leds/20210418213427.220638-1-marijn.suijten@somainline.org/
[3]: https://lore.kernel.org/linux-leds/20210915080252.69147-1-marijn.suijten@somainline.org/

- Marijn
