Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467305738FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbiGMOfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbiGMOfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:35:46 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9345237FB1;
        Wed, 13 Jul 2022 07:35:44 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (89-27-103-169.bb.dnainternet.fi [89.27.103.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 2EEF81B00027;
        Wed, 13 Jul 2022 17:35:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1657722941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L5hXIccoYd04jJwH1W8WMt/lLzG+tSm+SzTD5+NxH7s=;
        b=hZSIJirA2bNiWcGOvPT79KOwk/hlEzL7/HH+wY8dUJZRZAtKB++ScteIldWT60AusQg7ce
        ciObP8ElAm9I8ltBDJfFgWJvLL9seHbZD59a8ZVyN9djU7zyGUzqluqvVGPH6W5SdIzl6X
        ztAhk2T9oQtBz1G7KyiZkwKrhoBJFbZ+Dx7kCssCeUap37mGel4OIvymgWaTVmXEa8xHQb
        06ItDUZxdYTDzuQFEPJ391imblMyUQN0hZ3f5OafRe45LjxM2FodUit1JUr3TWtA4xf/Ox
        CTdvIUb6tyZcPW6xfaJ+n9boMevTpskgm9/iyHGg7RkiyOpge+lscoVTzWUuNg==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id B2BB9634D5E;
        Wed, 13 Jul 2022 17:35:40 +0300 (EEST)
Date:   Wed, 13 Jul 2022 17:35:40 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/6] media: dt-bindings: ov5693: document YAML binding
Message-ID: <Ys7YPIveQHRbG7BE@valkosipuli.retiisi.eu>
References: <20220712163349.1308540-1-tommaso.merciai@amarulasolutions.com>
 <20220712163349.1308540-6-tommaso.merciai@amarulasolutions.com>
 <1657664975.862137.2476655.nullmailer@robh.at.kernel.org>
 <20220713064845.GA1386778@tom-ThinkPad-T14s-Gen-2i>
 <87086513-787c-3b0d-80df-b90ebdc3a28c@linaro.org>
 <20220713132451.GA1725944@tom-ThinkPad-T14s-Gen-2i>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713132451.GA1725944@tom-ThinkPad-T14s-Gen-2i>
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1657722941; a=rsa-sha256;
        cv=none;
        b=PWyz3Tq7F1iUZxL4cfyNAieOpJhiduZst8kZwJwtJR4IkU8mstZ70WwY/lc4jqz3U6XNi0
        gjgKS3QDKXNR5rkQhkqKRJdAZ69DfWoH/82gppy+yKmvY4uThNPKDtVwI5EVtO/TOKSC6q
        f/nVt9LYGUM5cFCOw8ZrWLGCpoErWUADHOxwqdGeSnjqfYNNBUpDsa+E6KMtIEg/CQmwZA
        D4SVduY5U1+vZGRBoid+SJ7LnwqfrkhThEMex95l61Hzz9cYTuH23TK4zhrQ7+GEDXMb4s
        3gXqmz8QULXY5pQf4oK/HFyBLG8qvoSg/X9XaUPTFNbbHZQUFinZMYtHxyF9TA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1657722941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L5hXIccoYd04jJwH1W8WMt/lLzG+tSm+SzTD5+NxH7s=;
        b=owERJOUX9/jUfP5gORcIHDjaYp4sDx+IDpjDFgwYwSVCh8yA5RF98scST/ZyYhj2P//J9V
        1rfH+NfW0M/tvZVjNzAnht/7MJxRKJEzIBNexdjng/K3JmuuHawZAM5lNBkEPKpjzUhTwD
        knQSfrnKnTjyb+yfv5uw5fw1bi91jH/Uy+mhcRK49WYuNit6dpV9t3Y9Bg1PTbIkygD1vJ
        0j3hL5OEAc8VStqACOKgTIsZj0yYbiKSvV19fOLPk2TdOZu0aoVEwlb3/eKU7yQ0FZVjJX
        0zT14BCePN6Ch8uQa5uAXxrBl/KgnWjEuyV86SMx/ls8WVpAIAaEvmscm1mCwQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso, Krzysztof,

On Wed, Jul 13, 2022 at 03:24:51PM +0200, Tommaso Merciai wrote:
> On Wed, Jul 13, 2022 at 08:52:34AM +0200, Krzysztof Kozlowski wrote:
> > On 13/07/2022 08:48, Tommaso Merciai wrote:
> > > Hi Rob,
> > > 
> > > On Tue, Jul 12, 2022 at 04:29:35PM -0600, Rob Herring wrote:
> > >> On Tue, 12 Jul 2022 18:33:48 +0200, Tommaso Merciai wrote:
> > >>> Add documentation of device tree in YAML schema for the OV5693
> > >>> CMOS image sensor from Omnivision
> > >>>
> > >>> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> > >>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > >>> ---
> > >>> Changes since v1:
> > >>>  - Fix allOf position as suggested by Krzysztof
> > >>>  - Remove port description as suggested by Krzysztof
> > >>>  - Fix EOF as suggested by Krzysztof
> > >>>
> > >>> Changes since v2:
> > >>>  - Fix commit body as suggested by Krzysztof
> > >>>
> > >>> Changes since v3:
> > >>>  - Add reviewed-by tags, suggested by Jacopo, Krzysztof
> > >>>
> > >>> Changes since v4:
> > >>>  - Remove wrong Sakari reviewed-by tag, suggested by Krzysztof, Sakari
> > >>>
> > >>> Changes since v5:
> > >>>  - Remove dovdd-supply, avdd-supply, dvdd-supply from required properties
> > >>> as suggested by Jacopo
> > >>>
> > >>>  .../bindings/media/i2c/ovti,ov5693.yaml       | 103 ++++++++++++++++++
> > >>>  MAINTAINERS                                   |   1 +
> > >>>  2 files changed, 104 insertions(+)
> > >>>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> > >>>
> > >>
> > >> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > >> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > >>
> > >> yamllint warnings/errors:
> > >>
> > >> dtschema/dtc warnings/errors:
> > >> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.example.dtb: camera@36: Unevaluated properties are not allowed ('port' was unexpected)
> > >> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> > >>
> > >> doc reference errors (make refcheckdocs):
> > >>
> > >> See https://patchwork.ozlabs.org/patch/
> > >>
> > >> This check can fail if there are any dependencies. The base for a patch
> > >> series is generally the most recent rc1.
> > >>
> > >> If you already ran 'make dt_binding_check' and didn't see the above
> > >> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > >> date:
> > >>
> > >> pip3 install dtschema --upgrade
> > >>
> > >> Please check and re-submit.
> > >>
> > > 
> > > I run:
> > > 
> > > pip3 install dtschema --upgrade
> > > 
> > > Then I check .yaml using:
> > > 
> > > make DT_CHECKER_FLAGS=-m dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> > > DTEX    Documentation/devicetree/bindings/media/i2c/ovti,ov5693.example.dts
> > > LINT    Documentation/devicetree/bindings
> > > CHKDT   Documentation/devicetree/bindings/processed-schema.json
> > > SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > > DTC     Documentation/devicetree/bindings/media/i2c/ovti,ov5693.example.dtb
> > > CHECK   Documentation/devicetree/bindings/media/i2c/ovti,ov5693.example.dtb
> > > 
> > > No error on my side. I'm missing something?
> > 
> > Rob's check are running newer dtschema, from master branch. The error he
> > reports is about missing port, although I thought it is coming from
> > video-interface-devices.
> 
> Hi Krzysztof, 
> Thanks for the info! :)

These bindings are indeed missing the port node, please add one. See e.g.
Documentation/devicetree/bindings/media/i2c/ovti,ov02a10.yaml for an
example.

The reason why video-interfaces and video-interface-device are sparate is
because they deal with different nodes (device vs. port).

-- 
Kind regards,

Sakari Ailus
