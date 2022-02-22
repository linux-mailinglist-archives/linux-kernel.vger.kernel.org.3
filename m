Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F774BFAF0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiBVOau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiBVOas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:30:48 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E06015DDF6;
        Tue, 22 Feb 2022 06:30:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD73D139F;
        Tue, 22 Feb 2022 06:30:22 -0800 (PST)
Received: from [10.57.9.152] (unknown [10.57.9.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF56D3F5A1;
        Tue, 22 Feb 2022 06:30:20 -0800 (PST)
Message-ID: <38a2f694-3dd9-8d3f-68bd-986006499000@arm.com>
Date:   Tue, 22 Feb 2022 14:30:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC][PATCH 1/2] dt-bindings: power: add Energy Model bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     dianders@chromium.org, viresh.kumar@linaro.org, nm@ti.com,
        rafael@kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, devicetree@vger.kernel.org,
        daniel.lezcano@linaro.org, mka@chromium.org
References: <20220221225131.15836-1-lukasz.luba@arm.com>
 <20220221225131.15836-2-lukasz.luba@arm.com>
 <1645539763.088690.3016157.nullmailer@robh.at.kernel.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1645539763.088690.3016157.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


On 2/22/22 14:22, Rob Herring wrote:
> On Mon, 21 Feb 2022 22:51:30 +0000, Lukasz Luba wrote:
>> Add DT bindings for the Energy Model information.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   .../bindings/power/energy-model.yaml          | 51 +++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/energy-model.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/power/energy-model.yaml:34:5: [warning] wrong indentation: expected 2 but found 4 (indentation)
> ./Documentation/devicetree/bindings/power/energy-model.yaml:35:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
> ./Documentation/devicetree/bindings/power/energy-model.yaml:36:16: [warning] wrong indentation: expected 9 but found 15 (indentation)
> ./Documentation/devicetree/bindings/power/energy-model.yaml:35:39: [error] syntax error: expected ',' or '}', but got '{' (syntax)
> 
> dtschema/dtc warnings/errors:
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/power/energy-model.example.dts'
> Traceback (most recent call last):
>    File "/usr/local/bin/dt-extract-example", line 46, in <module>
>      binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
>    File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 434, in load
>      return constructor.get_single_data()
>    File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 119, in get_single_data
>      node = self.composer.get_single_node()
>    File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
>    File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
>    File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
>    File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
>    File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
>    File "_ruamel_yaml.pyx", line 891, in _ruamel_yaml.CParser._compose_mapping_node
>    File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
> ruamel.yaml.parser.ParserError: while parsing a flow mapping
>    in "<unicode string>", line 34, column 5
> did not find expected ',' or '}'
>    in "<unicode string>", line 35, column 39
> make[1]: *** [Documentation/devicetree/bindings/Makefile:25: Documentation/devicetree/bindings/power/energy-model.example.dts] Error 1
> make[1]: *** Waiting for unfinished jobs....
> ./Documentation/devicetree/bindings/power/energy-model.yaml:  while parsing a flow mapping
>    in "<unicode string>", line 34, column 5
> did not find expected ',' or '}'
>    in "<unicode string>", line 35, column 39
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/energy-model.yaml: ignoring, error parsing file
> make: *** [Makefile:1398: dt_binding_check] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/1595776
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

This new dt bindings idea is abandoned. We would go for
a new entry in the OPP node: "opp-microwatt".
I've sent a v2.

BTW, I've tried to run this check, but for some reason my python failed
when I tried to upgrade the dtschema:

'Could not find a version that satisfies the requirement 
jsonschema>=4.1.2 (from dtschema)'

It used to work. I'll probaby have to invest more time and figure
out why my pip3 fails.

Regards,
Lukasz
