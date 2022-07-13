Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8F5572E76
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiGMGwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGMGwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:52:41 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C202C48CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:52:39 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o12so9814313ljc.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3nO7y7+tf5/n/svc+0Txd3kP1zYYmkVd0Gxy5zDSfFY=;
        b=ESfoj0VWIoJj7fmwWsA6msq2l4T3Ru2J/MGoIeXbE7mtkRe5s03ZM7yHY+khHRK1Si
         vtBuIoxASf7qP0jT0j/a9PPlPdnbrVN+xaT+xX+o9uB02YLnlAUz9ARrTzwUv3V7DcMT
         sdH/+glyCpDj6atOISSziv7lUFDsyW9Cx7mcTXnylGazqAtgrJzEC00Dx9HsV4JqN6i+
         pzJpFc4eWYTTyLWS/1j6m3kpbKNADpzlZ+Qp0Fk0My+oZyxANnwlYSfLcTThV20UgmaU
         ldK+o+Xf0mVpdAjUWJi7ODWCZ+1u3wfBOHa3+u73i+E7MCBobWHP1xmnFWPCObyyZkQd
         8j7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3nO7y7+tf5/n/svc+0Txd3kP1zYYmkVd0Gxy5zDSfFY=;
        b=lKhuGrctct6pyxoyPmD3Hg3spSq7QaBgMzLLmdPQQN+1XjwWtXv3uFqMWIocFvZYQH
         XIUzFF8StXDMCTovFB62RVoJd8G9lKqQJ7IGmXC/QPmLZRBd+8kwNEuC47cFmJCfJKIO
         lrGkS/JtaxCu0lEMXypBU8WtHuYO/pezBvxRlZHVrjBQxaZMVeecZKysZzS91UkC0jML
         OhzlBN+/ud1Im/Ym9ciHRDH7xcXtqq/jfmtNJeTSrWs9vJB4dg7mTViqX7TQqkPk2YgQ
         XY6wlbGQhEcUWgFA9wnGI1UEN21mfH4pgBHpwnmi3Wo5VQ/M4+U9+Me3qdjllS3ujGYq
         1Dlw==
X-Gm-Message-State: AJIora+yXAtuRtFIBleYB34Nn39gfh6Ucec8HiPXZVF6qDhuE4ub/l4Y
        0XJOGUJlajqsXHARFEB48RprSQ==
X-Google-Smtp-Source: AGRyM1vSOE/hLwa67YD1MfgCh6naATtoe8QIQ3dtscQ9/kYiXU46x34jXlXSkSEd9L+8sZwzJKvV4Q==
X-Received: by 2002:a05:651c:10b0:b0:25d:5560:dab with SMTP id k16-20020a05651c10b000b0025d55600dabmr902386ljn.7.1657695158000;
        Tue, 12 Jul 2022 23:52:38 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id n13-20020a05651203ed00b0048724eb8cffsm2609935lfq.255.2022.07.12.23.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 23:52:37 -0700 (PDT)
Message-ID: <87086513-787c-3b0d-80df-b90ebdc3a28c@linaro.org>
Date:   Wed, 13 Jul 2022 08:52:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 5/6] media: dt-bindings: ov5693: document YAML binding
Content-Language: en-US
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-media@vger.kernel.org, quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220712163349.1308540-1-tommaso.merciai@amarulasolutions.com>
 <20220712163349.1308540-6-tommaso.merciai@amarulasolutions.com>
 <1657664975.862137.2476655.nullmailer@robh.at.kernel.org>
 <20220713064845.GA1386778@tom-ThinkPad-T14s-Gen-2i>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220713064845.GA1386778@tom-ThinkPad-T14s-Gen-2i>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 08:48, Tommaso Merciai wrote:
> Hi Rob,
> 
> On Tue, Jul 12, 2022 at 04:29:35PM -0600, Rob Herring wrote:
>> On Tue, 12 Jul 2022 18:33:48 +0200, Tommaso Merciai wrote:
>>> Add documentation of device tree in YAML schema for the OV5693
>>> CMOS image sensor from Omnivision
>>>
>>> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>> Changes since v1:
>>>  - Fix allOf position as suggested by Krzysztof
>>>  - Remove port description as suggested by Krzysztof
>>>  - Fix EOF as suggested by Krzysztof
>>>
>>> Changes since v2:
>>>  - Fix commit body as suggested by Krzysztof
>>>
>>> Changes since v3:
>>>  - Add reviewed-by tags, suggested by Jacopo, Krzysztof
>>>
>>> Changes since v4:
>>>  - Remove wrong Sakari reviewed-by tag, suggested by Krzysztof, Sakari
>>>
>>> Changes since v5:
>>>  - Remove dovdd-supply, avdd-supply, dvdd-supply from required properties
>>> as suggested by Jacopo
>>>
>>>  .../bindings/media/i2c/ovti,ov5693.yaml       | 103 ++++++++++++++++++
>>>  MAINTAINERS                                   |   1 +
>>>  2 files changed, 104 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.example.dtb: camera@36: Unevaluated properties are not allowed ('port' was unexpected)
>> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
>>
>> doc reference errors (make refcheckdocs):
>>
>> See https://patchwork.ozlabs.org/patch/
>>
>> This check can fail if there are any dependencies. The base for a patch
>> series is generally the most recent rc1.
>>
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade
>>
>> Please check and re-submit.
>>
> 
> I run:
> 
> pip3 install dtschema --upgrade
> 
> Then I check .yaml using:
> 
> make DT_CHECKER_FLAGS=-m dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> DTEX    Documentation/devicetree/bindings/media/i2c/ovti,ov5693.example.dts
> LINT    Documentation/devicetree/bindings
> CHKDT   Documentation/devicetree/bindings/processed-schema.json
> SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> DTC     Documentation/devicetree/bindings/media/i2c/ovti,ov5693.example.dtb
> CHECK   Documentation/devicetree/bindings/media/i2c/ovti,ov5693.example.dtb
> 
> No error on my side. I'm missing something?

Rob's check are running newer dtschema, from master branch. The error he
reports is about missing port, although I thought it is coming from
video-interface-devices.


Best regards,
Krzysztof
