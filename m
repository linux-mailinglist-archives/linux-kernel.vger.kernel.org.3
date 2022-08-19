Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9EE599C9B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348641AbiHSM6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349269AbiHSM6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:58:18 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C9FFF210;
        Fri, 19 Aug 2022 05:58:06 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1660913884; bh=s5P1/ldO6meakYSsej4N49VnAyA6qiJALD2PPNXMMsQ=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=Hr+iI8YFOPLdaTCZsreuXLflX6ftTmJgplJ+SzuSmXEdhkuSsx6sDp9GWrCR4Eb0X
         +Ci7PrTK0jp9F7S1QlYkdX7shv25Ze3dj2YC96kO8WKhIQh2q/0ezsu5yxzL01PRMI
         I86CcKeBHeRf08lwdBHsz65amSZ6VL31maa+i6wQ=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v2 1/4] dt-bindings: sound: Add Apple MCA I2S transceiver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20220819125430.4920-2-povik+lin@cutebit.org>
Date:   Fri, 19 Aug 2022 14:58:03 +0200
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE646B68-CA14-483C-A1AB-30358560DAAD@cutebit.org>
References: <20220819125430.4920-1-povik+lin@cutebit.org>
 <20220819125430.4920-2-povik+lin@cutebit.org>
To:     =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Philipp Zabel <p.zabel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 19. 8. 2022, at 14:54, Martin Povi=C5=A1er <povik+lin@cutebit.org> =
wrote:
>=20
> Add binding schema for MCA I2S transceiver found on Apple M1 and other
> chips.
>=20
> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
> ---
> .../devicetree/bindings/sound/apple,mca.yaml  | 131 ++++++++++++++++++
> 1 file changed, 131 insertions(+)
> create mode 100644 =
Documentation/devicetree/bindings/sound/apple,mca.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/sound/apple,mca.yaml =
b/Documentation/devicetree/bindings/sound/apple,mca.yaml
> new file mode 100644
> index 000000000000..7b4f348c2be3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/apple,mca.yaml
> @@ -0,0 +1,131 @@


> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t8103-mca
> +          - apple,t6000-mca

Since it was brought up last time but I didn=E2=80=99t respond: the
nonalphabetical order is as the chips were introduced (and
matches other schemas).

Martin

