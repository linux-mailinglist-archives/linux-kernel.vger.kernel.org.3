Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDEF50672F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350170AbiDSIwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350156AbiDSIwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:52:30 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDA4DC41;
        Tue, 19 Apr 2022 01:49:46 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 0A9B31C81111;
        Tue, 19 Apr 2022 16:49:45 +0800 (CST)
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 19
 Apr 2022 16:49:44 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Tue, 19 Apr
 2022 16:49:44 +0800
Received: from [172.19.1.47] (172.19.1.47) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 19 Apr 2022 16:49:44 +0800
Message-ID: <32867abe-49ae-ae8e-56dd-a0c80011f870@nuvoton.com>
Date:   Tue, 19 Apr 2022 16:49:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 2/5] dt-bindings: clock: Document MA35D1 clock
 controller bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <will@kernel.org>,
        <arnd@arndb.de>, <ychuang570808@gmail.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <olof@lixom.net>,
        <cfli0@nuvoton.com>, <soc@kernel.org>,
        <devicetree@vger.kernel.org>, <sboyd@kernel.org>
References: <20220418082738.11301-1-ychuang3@nuvoton.com>
 <20220418082738.11301-3-ychuang3@nuvoton.com>
 <1650288948.503037.3125298.nullmailer@robh.at.kernel.org>
From:   Jacky Huang <ychuang3@nuvoton.com>
In-Reply-To: <1650288948.503037.3125298.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/18 下午 09:35, Rob Herring wrote:
> On Mon, 18 Apr 2022 16:27:35 +0800, Jacky Huang wrote:
>> Add documentation to describe Nuvoton MA35D1 clock driver bindings.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   .../bindings/clock/nuvoton,ma35d1-clk.yaml    | 63 +++++++++++++++++++
>>   1 file changed, 63 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
>>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml:41:9: [error] syntax error: mapping values are not allowed here (syntax)
>
> dtschema/dtc warnings/errors:
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.example.dts'
> Traceback (most recent call last):
>    File "/usr/local/bin/dt-extract-example", line 52, in <module>
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
> ruamel.yaml.scanner.ScannerError: mapping values are not allowed in this context
>    in "<unicode string>", line 41, column 9
> make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.example.dts] Error 1
> make[1]: *** Waiting for unfinished jobs....
> ./Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml:  mapping values are not allowed in this context
>    in "<unicode string>", line 41, column 9
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml: ignoring, error parsing file
> make: *** [Makefile:1401: dt_binding_check] Error 2
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/
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
Thanks for your review.
I see this error and know where the problem is. I will fix it in the 
next version.

Sincerely,
Jacky Huang



