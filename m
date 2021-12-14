Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F22A473BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbhLNDrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:47:23 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33394 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhLNDrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:47:21 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BE3l0SI059276;
        Mon, 13 Dec 2021 21:47:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639453620;
        bh=sSUI+3XbCkWJC8iuEmPzjq99OubAAA0oFQ31cA0MhpA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HgmGgtYtjS/+21+jDL3Qdo38QnwnKO48L46s2HPUFDMkJt1nopdh1qkJXZUBj7SV0
         CazYg45gzVKd/ZMPUeQAx7y2T7358XmGqqpThV3rP0ttGUs7QDSIimb4KtD+I3wdgG
         XHAlzJ4TX0MlpERNQdl4j5C/iidTWKNwqbvkQDHA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BE3l0CH054348
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Dec 2021 21:47:00 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 13
 Dec 2021 21:46:59 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 13 Dec 2021 21:46:59 -0600
Received: from [10.250.232.185] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BE3kuDX023438;
        Mon, 13 Dec 2021 21:46:57 -0600
Subject: Re: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document
 mux-states property
To:     Rob Herring <robh@kernel.org>
CC:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211202131002.12217-1-a-govindraju@ti.com>
 <20211202131002.12217-2-a-govindraju@ti.com>
 <Ybeq5dNYjN4GOzdV@robh.at.kernel.org>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <05d52ca2-424b-94b5-4f0c-56dbbc5a0c22@ti.com>
Date:   Tue, 14 Dec 2021 09:16:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ybeq5dNYjN4GOzdV@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 14/12/21 1:49 am, Rob Herring wrote:
> On Thu, Dec 02, 2021 at 06:40:01PM +0530, Aswath Govindraju wrote:
>> On some boards, for routing CAN signals from controller to transceivers,
>> muxes might need to be set. This can be implemented using mux-states
>> property. Therefore, document the same in the respective bindings.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  .../devicetree/bindings/phy/ti,tcan104x-can.yaml    | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
>> index 6107880e5246..5b2b08016635 100644
>> --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
>> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
>> @@ -37,6 +37,18 @@ properties:
>>        max bit rate supported in bps
>>      minimum: 1
>>  
>> +  mux-states:
>> +    description:
>> +      mux controller node to route the signals from controller to
>> +      transceiver. Depending on the mux chip and the control lines
>> +      in it, the first and second parameters can be used for
>> +      representing control line and state. The number of arguments
>> +      is to be used based on '#mux-state-cells' property in the
>> +      mux-controller node. If '#mux-state-cells' is equal to
>> +      one then, then the argument to be used would be the state.
>> +      If it is set to two, then the first argument is the control
>> +      line and the second argument would be its corresponding state.
> 
> No need to redefine how a common property works here. What you do need 
> to define is how many entries and what they are for if more than 1. 
> 

Got it. So, I'll remove the common part that describes about the number
of arguments and only include what the arguments would mean given the
number of arguments


  mux-states:
    description:
      mux controller node to route the signals from controller to
      transceiver. Two arguments can be present depending on the mux
      chip. If mux-states has one argument then it represents the state.
      If there are two arguments then the first argument is the control
      line and the second argument is its corresponding state.


Thanks,
Aswath

> Rob
> 

