Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034575175B9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243899AbiEBRas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbiEBRar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:30:47 -0400
X-Greylist: delayed 4693 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 May 2022 10:27:17 PDT
Received: from 6.mo548.mail-out.ovh.net (6.mo548.mail-out.ovh.net [188.165.58.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F701A1A1
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:27:17 -0700 (PDT)
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.206])
        by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 40C7320A88;
        Mon,  2 May 2022 16:09:01 +0000 (UTC)
Received: from kaod.org (37.59.142.107) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 2 May
 2022 18:08:59 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-107S0015a36cd29-1587-4259-883a-5c3137477e16,
                    1C738C3314058F8CE8CF02D37F1FC3678EA14F63) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <449f47d2-f700-e71d-996b-ce30c6906d89@kaod.org>
Date:   Mon, 2 May 2022 18:08:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 02/11] dt-bindings: spi: Add Aspeed SMC controllers
 device tree binding
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Joel Stanley <joel@jms.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        <linux-kernel@vger.kernel.org>, Tao Ren <rentao.bupt@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>,
        Jae Hyun Yoo <quic_jaehyoo@quicinc.com>,
        <linux-aspeed@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
References: <20220502081341.203369-1-clg@kaod.org>
 <20220502081341.203369-3-clg@kaod.org>
 <1651505609.452113.1161768.nullmailer@robh.at.kernel.org>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <1651505609.452113.1161768.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.107]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 256f9c92-6a2e-4112-84d2-d224bad78371
X-Ovh-Tracer-Id: 152277964116167437
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehgdeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepudehkedtudfhgfelgffggfeffeefgefhudejvdekveeuveegieelteejiedugeevnecuffhomhgrihhnpehoiihlrggsshdrohhrghenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrth
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 17:33, Rob Herring wrote:
> On Mon, 02 May 2022 10:13:32 +0200, Cédric Le Goater wrote:
>> The "interrupt" property is optional because it is only necessary for
>> controllers supporting DMAs (Not implemented yet in the new driver).
>>
>> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
>> Tested-by: Joel Stanley <joel@jms.id.au>
>> Tested-by: Tao Ren <rentao.bupt@gmail.com>
>> Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   .../bindings/spi/aspeed,ast2600-fmc.yaml      | 82 +++++++++++++++++++
>>   MAINTAINERS                                   |  9 ++
>>   2 files changed, 91 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml:62:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

drat. I forgot to rerun the check after prettifying the example.

Will resend a v6 without the tabs.

Thanks,

C.

> 
> dtschema/dtc warnings/errors:
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.example.dts'
> Traceback (most recent call last):
>    File "/usr/local/bin/dt-extract-example", line 52, in <module>
>      binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
>    File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/main.py", line 434, in load
>      return constructor.get_single_data()
>    File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/constructor.py", line 119, in get_single_data
>      node = self.composer.get_single_node()
>    File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
>    File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
>    File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
>    File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
>    File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
>    File "_ruamel_yaml.pyx", line 848, in _ruamel_yaml.CParser._compose_sequence_node
>    File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
> ruamel.yaml.scanner.ScannerError: while scanning a block scalar
>    in "<unicode string>", line 49, column 5
> found a tab character where an indentation space is expected
>    in "<unicode string>", line 62, column 1
> make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.example.dts] Error 1
> make[1]: *** Waiting for unfinished jobs....
> ./Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml:  while scanning a block scalar
>    in "<unicode string>", line 49, column 5
> found a tab character where an indentation space is expected
>    in "<unicode string>", line 62, column 1
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml: ignoring, error parsing file
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

