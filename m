Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB5251D51F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390780AbiEFKG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358846AbiEFKGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:06:19 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDFF5AA59;
        Fri,  6 May 2022 03:02:35 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2467Y07k015868;
        Fri, 6 May 2022 12:02:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=3m0mw1nBjzDm+VBX3E2ez2EscVLtrOMj3hZ9LGKIYvI=;
 b=av6DvpN0ABdk6r6R1R3POxkZs1JjpU1qKDY6IVVoUtipgGWLu3IWroKgeKaibkNUkhm6
 tf5JhMUURsISmllmKZBUAFGI9eli6oACSW6j24CyLlqeMyL+h8tPe01kChPyan3uAXzo
 +50DjdH+BGUyjGu7Uy1qyZp8ppFy/BP15C20844nfXnxgiKBHy6jRNxyFjU+X5CC3Bni
 SuCO1/QMmJY/hML6CkG7sXNF8oUhQDxSA/VbPt27DDNlXlcywQmHO17KfBjCq4n/pjKN
 Cl05PfULMFHYUXVccloj/xSOXGUB129kSzEB+POJzMpjF9uKTe9DYtKatbQtgD/2GqZX +g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frvf104sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 12:02:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7421E100034;
        Fri,  6 May 2022 12:02:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5BD7A2171E1;
        Fri,  6 May 2022 12:02:12 +0200 (CEST)
Received: from [10.201.21.93] (10.75.127.45) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 6 May
 2022 12:02:11 +0200
Message-ID: <edf8f01b-e850-1734-2909-f31cd8b082c5@foss.st.com>
Date:   Fri, 6 May 2022 12:02:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/8] dt-bindings: clock: stm32mp1: describes clocks if
 "st,stm32mp1-rcc-secure"
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        SoC Team <soc@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marex@denx.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Etienne Carriere <etienne.carriere@st.com>
References: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
 <20220422150952.20587-3-alexandre.torgue@foss.st.com>
 <CAL_JsqKU28BNrozg20_a_XMUmBhaoDHdodWkzyRoH=VcM2pDjg@mail.gmail.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <CAL_JsqKU28BNrozg20_a_XMUmBhaoDHdodWkzyRoH=VcM2pDjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_03,2022-05-05_01,2022-02-23_01
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

On 5/5/22 16:11, Rob Herring wrote:
> On Fri, Apr 22, 2022 at 10:10 AM Alexandre Torgue
> <alexandre.torgue@foss.st.com> wrote:
>>
>> In case of "st,stm32mp1-rcc-secure" (stm32mp1 clock driver with RCC
>> security support hardened), "clocks" and "clock-names" describe oscillators
>> and are required.
>>
>> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> This is now failing in linux-next:
> 
> make[1]: *** Deleting file
> 'Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.example.dts'
> Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml: found
> duplicate key "clocks" with value "{}" (original value: "True")
> make[1]: *** [Documentation/devicetree/bindings/Makefile:26:
> Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.example.dts]
> Error 1
> ./Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml:64:3:
> [error] duplication of key "clocks" in mapping (key-duplicates)
> ./Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml:69:3:
> [error] duplication of key "clock-names" in mapping (key-duplicates)
> Traceback (most recent call last):
>    File "/usr/local/bin/dt-doc-validate", line 25, in check_doc
>      testtree = dtschema.load(filename, line_number=line_number)
>    File "/usr/local/lib/python3.10/dist-packages/dtschema/lib.py", line
> 914, in load
>      return yaml.load(f.read())
>    File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/main.py",
> line 434, in load
>      return constructor.get_single_data()
>    File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/constructor.py",
> line 121, in get_single_data
>      return self.construct_document(node)
>    File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/constructor.py",
> line 131, in construct_document
>      for _dummy in generator:
>    File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/constructor.py",
> line 674, in construct_yaml_map
>      value = self.construct_mapping(node)
>    File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/constructor.py",
> line 445, in construct_mapping
>      return BaseConstructor.construct_mapping(self, node, deep=deep)
>    File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/constructor.py",
> line 263, in construct_mapping
>      if self.check_mapping_key(node, key_node, mapping, key, value):
>    File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/constructor.py",
> line 294, in check_mapping_key
>      raise DuplicateKeyError(*args)
> ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
>    in "<unicode string>", line 49, column 3
> found duplicate key "clocks" with value "{}" (original value: "True")
>    in "<unicode string>", line 64, column 3
> To suppress this check see:
>      http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys
> During handling of the above exception, another exception occurred:
> Traceback (most recent call last):
>    File "/usr/local/bin/dt-doc-validate", line 74, in <module>
>      ret = check_doc(f)
>    File "/usr/local/bin/dt-doc-validate", line 30, in check_doc
>      print(filename + ":", exc.path[-1], exc.message, file=sys.stderr)
> AttributeError: 'DuplicateKeyError' object has no attribute 'path'

It seems that we have a merge issue between:

patch "dt-bindings: rcc: Add optional external ethernet RX clock properties"
https://lore.kernel.org/r/20220410220514.21779-1-marex@denx.de

and this one (dt-bindings: clock: stm32mp1: describes clocks if 
"st,stm32mp1-rcc-secure)

On linux-next following part remains and creates issue above:

   clocks:
     description:
       Specifies the external RX clock for ethernet MAC.
     maxItems: 1

   clock-names:
     const: ETH_RX_CLK/ETH_REF_CLK

I don't know why this part is remaining. In my tree, I took care to take 
Marek patch first to avoid this kind of issue.

Btw, how to fix that ?

Note, that as soon as we will fix this point I'll send a fix to avoid 
issue in example build.

cheers
Alex







