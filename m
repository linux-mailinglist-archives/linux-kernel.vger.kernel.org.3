Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F5453DDAB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 20:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351472AbiFESbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 14:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbiFESb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 14:31:28 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CF912AAF;
        Sun,  5 Jun 2022 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654453887; x=1685989887;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xHQW/DoGQUs+0ZrxEQ1m+x/wIrTBq1nQRjID76ZhMk0=;
  b=iP16Cec5Ggg8tQj2jV8ZTfhHF8beWLBfHGque7rJlCjdOiQy1vDcmoAK
   3IfN+x3U7nXqYB1yt57/oQPJf7yKRqG8mHLybokVtsfy6kQlvy0yxEsZd
   V6nrQ881AfLWpCPoR5E/f8cZYFSI45pupsYgzsqLhbzKVNcM1N4dlgnOC
   U=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Jun 2022 11:31:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 11:31:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 5 Jun 2022 11:31:26 -0700
Received: from [10.216.59.27] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 5 Jun 2022
 11:31:22 -0700
Message-ID: <62c0b6ac-240c-e581-7bc3-9357dc619d4c@quicinc.com>
Date:   Mon, 6 Jun 2022 00:01:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC v2 1/2] dt-bindings: usb: dwc3: Add support for multiport
 related properties
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <quic_pkondeti@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <quic_ppratap@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <1653560029-6937-1-git-send-email-quic_harshq@quicinc.com>
 <1653560029-6937-2-git-send-email-quic_harshq@quicinc.com>
 <1653568833.732260.3797150.nullmailer@robh.at.kernel.org>
 <33ce11bd-abc4-0e59-4637-e8133818e0f6@quicinc.com>
 <20220531201050.GD1808817-robh@kernel.org>
From:   Harsh Agarwal <quic_harshq@quicinc.com>
In-Reply-To: <20220531201050.GD1808817-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/1/2022 1:40 AM, Rob Herring wrote:
> On Fri, May 27, 2022 at 04:30:34PM +0530, Harsh Agarwal wrote:
>> On 5/26/2022 6:10 PM, Rob Herring wrote:
>>> On Thu, 26 May 2022 15:43:48 +0530, Harsh Agarwal wrote:
>>>> Added support for multiport, mport, num-ssphy and num-hsphy
>>>> properties. These properties are used to support devices having
>>>> a multiport controller.
>>>>
>>>> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
>>>> ---
>>>>    .../devicetree/bindings/usb/snps,dwc3.yaml         | 55 ++++++++++++++++++++++
>>>>    1 file changed, 55 insertions(+)
>>>>
>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>
>>> yamllint warnings/errors:
>>> ./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:366:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
>>> ./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:367:10: [warning] wrong indentation: expected 11 but found 9 (indentation)
>>> ./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:369:11: [warning] wrong indentation: expected 11 but found 10 (indentation)
>>>
>>> dtschema/dtc warnings/errors:
>>> Documentation/devicetree/bindings/usb/snps,dwc3.example.dts:86.27-89.15: Warning (unit_address_vs_reg): /example-2/usb@4a000000/multiport/mport@1: node has a unit name, but no reg or ranges property
>>> Documentation/devicetree/bindings/usb/snps,dwc3.example.dts:91.27-93.15: Warning (unit_address_vs_reg): /example-2/usb@4a000000/multiport/mport@2: node has a unit name, but no reg or ranges property
>>> Documentation/devicetree/bindings/usb/snps,dwc3.example.dts:95.27-97.15: Warning (unit_address_vs_reg): /example-2/usb@4a000000/multiport/mport@3: node has a unit name, but no reg or ranges property
>>> Documentation/devicetree/bindings/usb/snps,dwc3.example.dts:99.27-101.15: Warning (unit_address_vs_reg): /example-2/usb@4a000000/multiport/mport@4: node has a unit name, but no reg or ranges property
>>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/snps,dwc3.example.dtb: usb@4a000000: multiport: 'mport' is a required property
>>> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>
>>> doc reference errors (make refcheckdocs):
>>>
>>> See https://patchwork.ozlabs.org/patch/
>>>
>>> This check can fail if there are any dependencies. The base for a patch
>>> series is generally the most recent rc1.
>>>
>>> If you already ran 'make dt_binding_check' and didn't see the above
>>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>>> date:
>>>
>>> pip3 install dtschema --upgrade
>>>
>>> Please check and re-submit.
>> Indentation error I have rectified in my RFC v2.
>> Regarding below warnings
>>
>> "Documentation/devicetree/bindings/usb/snps,dwc3.example.dts:86.27-89.15: Warning (unit_address_vs_reg): /example-2/usb@4a000000/multiport/mport@1: node has a unit name, but no reg or ranges property"
>> Here the mport expects no "reg" or ranges" property as of now. Only thing that is mandated is either the USB-PHY phandles using "usb-phy" or the Generic PHY declaration using "phy" and "phy-names"
>> Can you please suggest to mask these warnings or do I need to add something else ?
> A unit-address requires 'reg' or 'ranges' and vice-versa. So you need
> 'reg'.
>
> However, usb-hcd.yaml already defines what child nodes are for USB
> hosts. Whatever you do here needs to be compatible with that.
Thanks for the info.
"@" is not actually a requirement for mport.
We can name them as "mport1" instead of "mport@1".
Now I do not see this reg, ranges warnings in latest PS v2
>
> Rob
