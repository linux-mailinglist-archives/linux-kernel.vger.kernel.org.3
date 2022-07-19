Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DAD57A8EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbiGSVXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbiGSVXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:23:38 -0400
X-Greylist: delayed 260 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Jul 2022 14:23:33 PDT
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57C56053A;
        Tue, 19 Jul 2022 14:23:32 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 0D24520076;
        Tue, 19 Jul 2022 23:23:31 +0200 (CEST)
Date:   Tue, 19 Jul 2022 23:23:29 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     phone-devel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: leds: qcom-lpg: Add compatible for
 PM660L LPG block
Message-ID: <20220719212329.7yuky2jofpn7uaq7@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        phone-devel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220511190718.764445-1-marijn.suijten@somainline.org>
 <056cc963-4cf4-8588-f75c-e4530aeb6220@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <056cc963-4cf4-8588-f75c-e4530aeb6220@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-19 02:35:50, Bhupesh Sharma wrote:
> 
> On 5/12/22 12:37 AM, Marijn Suijten wrote:
> > Document the availability of an LPG configuration for the PM660L PMIC in
> > the Qualcomm Light Pulse Generator driver.
> >
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> >   Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> > index 409a4c7298e1..cd02811583ec 100644
> > --- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> > +++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> > @@ -17,6 +17,7 @@ description: >
> >   properties:
> >     compatible:
> >       enum:
> > +      - qcom,pm660l-lpg
> >         - qcom,pm8150b-lpg
> >         - qcom,pm8150l-lpg
> >         - qcom,pm8350c-pwm
> 
> 
> This patch seems to have slipped through the cracks, as running a
> 
> 'make dtbs_check' currently on linux-next tip causes the following issue:
> 
> arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb:0:0: 
> /soc/spmi@800f000/pmic@3/lpg@b100:
>    failed to match any schema with compatible: ['qcom,pm660l-lpg']
> 
> If it helps:
> 
> Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks.  It is not only this patch but also the accompanying driver
change; both have to go through the leds tree.  Bjorn already picked the
DTS patches as they have to go through the Qcom DTS tree.

I've resent a rebased v4, solving some context markers jumping to
different lines and dropping applied patches to hopefully make it clear
that only these are outstanding.  Feel free to submit your Reviewed-by:
to the driver patch as well in hopes of making it in with the DTS
changes for 5.20:

https://lore.kernel.org/linux-arm-msm/20220719211848.1653920-1-marijn.suijten@somainline.org/T/#t

Thanks!
- Marijn
