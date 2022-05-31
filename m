Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C4F5397D1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347684AbiEaUKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244956AbiEaUKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:10:53 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1AD972B8;
        Tue, 31 May 2022 13:10:52 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e656032735so19899168fac.0;
        Tue, 31 May 2022 13:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=syZte8VMFYIrvqwLV7B4xdi4mb5JASYHy9v3uwzX/Uk=;
        b=U0n4phY9WYv/Ni/EFKG0Ln0XCOsYFnsrJOHXOHEtpVKYwQD9OywNiY6rHKGW4K/Flb
         CxucKzGvJ7u8XttPgsw1kR2hgg/Ixq5pI0O4r1p9dJWUpdautE0wq2RvEWocUD4GLzb9
         zAW7DMn/mhPSXsR+PQYXP4ty/Lwil9sRBoPf6H5C5pxS/UUgPF2Gavdjzs+4C3HACbia
         fIuzQoZZlOFJqQ+J1iLPaQjQ+t0OoVZw6IcKAlcB4ZD2sJtNXeZvTeh6zK25sRtg7TTJ
         3Dr/IL61XdbbEx+vqRuEzJSteP4MVojjXwFuzo3iiNv1W97pt0Ph+QfGoorA7Nh714tP
         zsOQ==
X-Gm-Message-State: AOAM531zHfUBLVO3hZXVxaniEUbhJGnKOhYmKilAQrjroOExtad8YlgG
        BzG9Ooz5vUAl3tAq+XQQvQ==
X-Google-Smtp-Source: ABdhPJwuGMM5LGvvT0reg6w0YES9zGykPNIMnjPS+0QJgmckJRbrz66grBPVW056W4xldPyHkoNpmw==
X-Received: by 2002:a05:6870:c22c:b0:f5:701f:16d9 with SMTP id z44-20020a056870c22c00b000f5701f16d9mr3094306oae.35.1654027851564;
        Tue, 31 May 2022 13:10:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bg41-20020a05680817a900b0032617532120sm6521539oib.48.2022.05.31.13.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 13:10:51 -0700 (PDT)
Received: (nullmailer pid 2201482 invoked by uid 1000);
        Tue, 31 May 2022 20:10:50 -0000
Date:   Tue, 31 May 2022 15:10:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Harsh Agarwal <quic_harshq@quicinc.com>
Cc:     quic_pkondeti@quicinc.com, Philipp Zabel <p.zabel@pengutronix.de>,
        quic_ppratap@quicinc.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [RFC v2 1/2] dt-bindings: usb: dwc3: Add support for multiport
 related properties
Message-ID: <20220531201050.GD1808817-robh@kernel.org>
References: <1653560029-6937-1-git-send-email-quic_harshq@quicinc.com>
 <1653560029-6937-2-git-send-email-quic_harshq@quicinc.com>
 <1653568833.732260.3797150.nullmailer@robh.at.kernel.org>
 <33ce11bd-abc4-0e59-4637-e8133818e0f6@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33ce11bd-abc4-0e59-4637-e8133818e0f6@quicinc.com>
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

On Fri, May 27, 2022 at 04:30:34PM +0530, Harsh Agarwal wrote:
> 
> On 5/26/2022 6:10 PM, Rob Herring wrote:
> > On Thu, 26 May 2022 15:43:48 +0530, Harsh Agarwal wrote:
> > > Added support for multiport, mport, num-ssphy and num-hsphy
> > > properties. These properties are used to support devices having
> > > a multiport controller.
> > > 
> > > Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> > > ---
> > >   .../devicetree/bindings/usb/snps,dwc3.yaml         | 55 ++++++++++++++++++++++
> > >   1 file changed, 55 insertions(+)
> > > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > ./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:366:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
> > ./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:367:10: [warning] wrong indentation: expected 11 but found 9 (indentation)
> > ./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:369:11: [warning] wrong indentation: expected 11 but found 10 (indentation)
> > 
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/usb/snps,dwc3.example.dts:86.27-89.15: Warning (unit_address_vs_reg): /example-2/usb@4a000000/multiport/mport@1: node has a unit name, but no reg or ranges property
> > Documentation/devicetree/bindings/usb/snps,dwc3.example.dts:91.27-93.15: Warning (unit_address_vs_reg): /example-2/usb@4a000000/multiport/mport@2: node has a unit name, but no reg or ranges property
> > Documentation/devicetree/bindings/usb/snps,dwc3.example.dts:95.27-97.15: Warning (unit_address_vs_reg): /example-2/usb@4a000000/multiport/mport@3: node has a unit name, but no reg or ranges property
> > Documentation/devicetree/bindings/usb/snps,dwc3.example.dts:99.27-101.15: Warning (unit_address_vs_reg): /example-2/usb@4a000000/multiport/mport@4: node has a unit name, but no reg or ranges property
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/snps,dwc3.example.dtb: usb@4a000000: multiport: 'mport' is a required property
> > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/patch/
> > 
> > This check can fail if there are any dependencies. The base for a patch
> > series is generally the most recent rc1.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit.
> Indentation error I have rectified in my RFC v2.
> Regarding below warnings
> 
> "Documentation/devicetree/bindings/usb/snps,dwc3.example.dts:86.27-89.15: Warning (unit_address_vs_reg): /example-2/usb@4a000000/multiport/mport@1: node has a unit name, but no reg or ranges property"
> Here the mport expects no "reg" or ranges" property as of now. Only thing that is mandated is either the USB-PHY phandles using "usb-phy" or the Generic PHY declaration using "phy" and "phy-names"
> Can you please suggest to mask these warnings or do I need to add something else ?

A unit-address requires 'reg' or 'ranges' and vice-versa. So you need 
'reg'.

However, usb-hcd.yaml already defines what child nodes are for USB 
hosts. Whatever you do here needs to be compatible with that.

Rob
