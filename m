Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B9E52760E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 08:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbiEOGg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 02:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbiEOGgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 02:36:54 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781C418E2B
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 23:36:53 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id j12so15071127oie.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 23:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abJLZGgjMfh8rX+ZbBZ6JRfVrVVL/LGIcKNrpQhfC6Y=;
        b=dNcMrWiXPhoSPTPD7rYo6oHnpWej3ftK/aEsS7ZG3mLHGEdc021KTOLN4BM/XHaDgZ
         Sg3f23g6pqjHlV6RNZFBaS5NCICddZLu2Wp8lVDciiiEMGlYn/ppyWvFJibpAjo9j1id
         PMpN+ZQit8Yg4yXMogWGuqsosp4c7ItvCmmYVoXo2LGKFXuox6tPZRDCA6g0ntAnLuBI
         Zr1xz5A3aYC2i6kau0Mw86sU8HuLczhZDc36+YHfhAus6f20QW0noDr1NreFrT3V+bxR
         2zRgIp5nytpyZOyduMqFD2hK1qKhUN3ZkKRRIdSYU2a0matUT6H23NTZfHpIm6BxH4eI
         vghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abJLZGgjMfh8rX+ZbBZ6JRfVrVVL/LGIcKNrpQhfC6Y=;
        b=AFkQMZzfYW/ablu/NOvDUOexgLBn4NxIeiBCSEB6uM1cPNYQpWl4LaFcjLcxvrfssk
         eEQ6f9IBtjWpuclHp4KPbvExjF6hM6bB2bfExC8/1xwIkE84qJu7lhWQ51Fej7QMbKCp
         0wQr9G2DUrLPfy0xjM1JfF0C1TAN/Y/3I6QoLlkp47Hb1w3q5Je5BAdwgxKYUKArG9pB
         8iDe2VF7R0dA3iNWXAnWAJBTLIwjruLUvJNUuPU7OVXeTpUZ4pNw+8rK9Q1Qw0UvEi5X
         JBfkvZI1Uwsb1zaK+sVd9hYuurd3NNiTQvdOJEINTZ+ti8sBf93yik3L0mJeP47zrdu4
         WN5A==
X-Gm-Message-State: AOAM532eoY1ibJTC8h0hEgmbBgXn1twfjQe8rJaIgQDnoXzRbp66Kx8o
        8hyFyMNFi3+UAzyHvtvjCkOA+NwIHEuQTkLD+0Nl/w==
X-Google-Smtp-Source: ABdhPJz+cF7Kgs9VRE4OciEFza03OApRMb4mZkLk1e9pqh/Cf7HxV9If/lRjpTi+G192d0vuzGfI8DTUQ9JaQqo3XL4=
X-Received: by 2002:a05:6808:dc3:b0:2ef:86e7:a0b with SMTP id
 g3-20020a0568080dc300b002ef86e70a0bmr5601383oic.48.1652596612750; Sat, 14 May
 2022 23:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220418205509.1102109-1-bhupesh.sharma@linaro.org>
 <20220418205509.1102109-2-bhupesh.sharma@linaro.org> <YmQfZ+h5tD6KbMID@ripper>
In-Reply-To: <YmQfZ+h5tD6KbMID@ripper>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Sun, 15 May 2022 12:06:39 +0530
Message-ID: <CAH=2NtzEBwuo+vm8-2Drn4P7SiUbV-aNL1zVDs8OahFEargCiQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: phy: qcom,qmp: Mark '#clock-cells' as
 a 'optional' property
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        bhupesh.linux@gmail.com, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, vkoul@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Sat, 23 Apr 2022 at 21:14, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 18 Apr 13:55 PDT 2022, Bhupesh Sharma wrote:
>
> > '#clock-cells' is not a required property for qmp-phy(s) in the
> > '/' node, but it should be is used in 'phy@' subnode (where it is
> > actually a 'required' property). Fix the same.
> >
>
> It's not that #clock-cells is "not a required property", it's that the
> clock comes out of the phy (the child node), so there is no clocks
> provided by the parent device.
>
>
> Please rewrite the commit message.

Ok.

> > This also fixes the following 'make dtbs_check' warning(s):
> >
> > sm8350-microsoft-surface-duo2.dt.yaml: phy@1d87000:
> >   '#clock-cells' is a required property
> >
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> > index 8b850c5ab116..c39ead81ecd7 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> > @@ -66,9 +66,6 @@ properties:
> >        - description: Address and length of PHY's common serdes block.
> >        - description: Address and length of PHY's DP_COM control block.
> >
> > -  "#clock-cells":
> > -    enum: [ 1, 2 ]
> > -
> >    "#address-cells":
> >      enum: [ 1, 2 ]
> >
> > @@ -112,11 +109,13 @@ patternProperties:
> >      description:
> >        Each device node of QMP phy is required to have as many child nodes as
> >        the number of lanes the PHY has.
> > +    properties:
> > +      "#clock-cells":
> > +        enum: [ 0, 1, 2 ]
>
> The commit message doesn't mention the fact that 0 is also a valid
> value. Perhaps just keep it [1, 2] in this patch?

0 is a valid value as mentioned in the example inside the dt-binding
example itself.
For e.g. see the 'sdm845-qmp-pcie-phy' node:

    pcie0_phy: phy@1c06000 {
            compatible = "qcom,sdm845-qmp-pcie-phy";
            <..snip..>

            pcie0_lane: phy@1c06200 {
                    <..snip..>

                #clock-cells = <0>;

So, without [ 0, 1, 2 ] in the yaml bindings we get the following
error while running '$ make dt_binding_check' :
qcom,qmp-phy.example.dtb: phy-wrapper@88eb000:
phy@200:#clock-cells:0:0: 0 is not one of [1, 2]

Thanks,
Bhupesh

> >
> >  required:
> >    - compatible
> >    - reg
> > -  - "#clock-cells"
> >    - "#address-cells"
> >    - "#size-cells"
> >    - ranges
> > @@ -468,7 +467,6 @@ examples:
> >      usb_2_qmpphy: phy-wrapper@88eb000 {
> >          compatible = "qcom,sdm845-qmp-usb3-uni-phy";
> >          reg = <0x088eb000 0x18c>;
> > -        #clock-cells = <1>;
> >          #address-cells = <1>;
> >          #size-cells = <1>;
> >          ranges = <0x0 0x088eb000 0x2000>;
> > --
> > 2.35.1
> >
