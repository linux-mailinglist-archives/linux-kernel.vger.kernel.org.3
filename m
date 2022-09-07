Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDA05B0025
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiIGJPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIGJPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:15:08 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907AD2715F;
        Wed,  7 Sep 2022 02:15:06 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2879EoX5099504;
        Wed, 7 Sep 2022 04:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662542090;
        bh=jq2OfRlva5di9Vn4eHGrTV4oiKwUCDWB2+lxGTVYHMY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=QBFTHZdg6YDR80M9fuUTIMdmUwj6p0i/XyWz2UdhpkOlJL3mDgfeKOefvaSqtpkbU
         WFMaE1mZzTR3seyurCwOwinjXXseJfyvxZBxiVtlGDetw4aAaduqcm8MHFW1p0E8zg
         lh0RVRUm/8ENuzEOyUYBEylb05NLzjwCCktvR+g0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2879EoUL082708
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Sep 2022 04:14:50 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 7 Sep
 2022 04:14:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 7 Sep 2022 04:14:50 -0500
Received: from [10.24.69.114] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2879EjNI025985;
        Wed, 7 Sep 2022 04:14:46 -0500
Message-ID: <28a2b54a-9105-d848-92bb-e4742ee3448a@ti.com>
Date:   Wed, 7 Sep 2022 14:44:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [EXTERNAL] Re: [PATCH v5 6/6] remoteproc: pru: add support for
 configuring GPMUX based on client setup
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nm@ti.com>, <ssantosh@kernel.org>, <s-anna@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <rogerq@kernel.org>,
        <grygorii.strashko@ti.com>, <vigneshr@ti.com>, <kishon@ti.com>,
        <robh@kernel.org>
References: <20220607045650.4999-1-p-mohan@ti.com>
 <20220607045650.4999-7-p-mohan@ti.com> <20220719161625.GB3393732@p14s>
 <49d1959e-88ae-c605-aafc-ca9819c4f85c@ti.com> <20220906192949.GA64477@p14s>
From:   Md Danish Anwar <a0501179@ti.com>
In-Reply-To: <20220906192949.GA64477@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu

On 07/09/22 00:59, Mathieu Poirier wrote:
> Good day,
> 
> On Mon, Sep 05, 2022 at 02:41:27PM +0530, Md Danish Anwar wrote:
>> Hi Mathieu,
>>
>> On 19/07/22 21:46, Mathieu Poirier wrote:
>>> On Tue, Jun 07, 2022 at 10:26:50AM +0530, Puranjay Mohan wrote:
>>>> From: Tero Kristo <t-kristo@ti.com>
>>>>
>>>> Client device node property ti,pruss-gp-mux-sel can now be used to
>>>> configure the GPMUX config value for PRU.
>>>>
>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>> [s-anna@ti.com: simplify the pru id usage]
>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
>>>> ---
>>>> V4->v5
>>>> * This patch was included in v4 and had some checkpatch errors that have
>>>>   been resolved in v5
>>>> ---
>>>>  drivers/remoteproc/pru_rproc.c | 20 ++++++++++++++++++++
>>>>  1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
>>>> index 2977eb50631b..f2c6c55f0f20 100644
>>>> --- a/drivers/remoteproc/pru_rproc.c
>>>> +++ b/drivers/remoteproc/pru_rproc.c
>>>> @@ -123,6 +123,7 @@ struct pru_private_data {
>>>>   * @dbg_single_step: debug state variable to set PRU into single step mode
>>>>   * @dbg_continuous: debug state variable to restore PRU execution mode
>>>>   * @evt_count: number of mapped events
>>>> + * @gpmux_save: saved value for gpmux config
>>>>   */
>>>>  struct pru_rproc {
>>>>  	int id;
>>>> @@ -141,6 +142,7 @@ struct pru_rproc {
>>>>  	u32 dbg_single_step;
>>>>  	u32 dbg_continuous;
>>>>  	u8 evt_count;
>>>> +	u8 gpmux_save;
>>>>  };
>>>>  
>>>>  static inline u32 pru_control_read_reg(struct pru_rproc *pru, unsigned int reg)
>>>> @@ -250,6 +252,7 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
>>>>  	struct device *dev;
>>>>  	const char *fw_name;
>>>>  	int ret;
>>>> +	u32 mux;
>>>>  
>>>>  	try_module_get(THIS_MODULE);
>>>>  
>>>> @@ -273,6 +276,22 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
>>>>  
>>>>  	mutex_unlock(&pru->lock);
>>>>  
>>>> +	ret = pruss_cfg_get_gpmux(pru->pruss, pru->id, &pru->gpmux_save);
>>>> +	if (ret) {
>>>> +		dev_err(dev, "failed to get cfg gpmux: %d\n", ret);
>>>> +		goto err;
>>>> +	}
>>>> +
>>>> +	ret = of_property_read_u32_index(np, "ti,pruss-gp-mux-sel", index,
>>>> +					 &mux);
>>>> +	if (!ret) {
>>>> +		ret = pruss_cfg_set_gpmux(pru->pruss, pru->id, mux);
>>>> +		if (ret) {
>>>> +			dev_err(dev, "failed to set cfg gpmux: %d\n", ret);
>>>> +			goto err;
>>>> +		}
>>>> +	}
>>>> +
>>>>  	if (pru_id)
>>>>  		*pru_id = pru->id;
>>>>  
>>>> @@ -310,6 +329,7 @@ void pru_rproc_put(struct rproc *rproc)
>>>>  
>>>>  	pru = rproc->priv;
>>>>  
>>>> +	pruss_cfg_set_gpmux(pru->pruss, pru->id, pru->gpmux_save);
>>>>  	pru_rproc_set_firmware(rproc, NULL);
>>>>
>>>
>>>   CC      drivers/remoteproc/pru_rproc.o
>>> /home/mpoirier/work/remoteproc/kernel-review/drivers/remoteproc/pru_rproc.c: In function ‘pru_rproc_get’:
>>> /home/mpoirier/work/remoteproc/kernel-review/drivers/remoteproc/pru_rproc.c:279:8: error: implicit declaration of function ‘pruss_cfg_get_gpmux’ [-Werror=implicit-function-declaration]
>>>   279 |  ret = pruss_cfg_get_gpmux(pru->pruss, pru->id, &pru->gpmux_save);
>>>       |        ^~~~~~~~~~~~~~~~~~~
>>> /home/mpoirier/work/remoteproc/kernel-review/drivers/remoteproc/pru_rproc.c:288:9: error: implicit declaration of function ‘pruss_cfg_set_gpmux’ [-Werror=implicit-function-declaration]
>>>   288 |   ret = pruss_cfg_set_gpmux(pru->pruss, pru->id, mux);
>>>       |         ^~~~~~~~~~~~~~~~~~~
>>>
>>> I get this on both rproc-next and today's linux next.  
>>
>> This patch is dependent on the series [2] Introduce PRU platform consumer API
>> https://patchwork.kernel.org/project/linux-remoteproc/cover/20220406094358.7895-1-p-mohan@ti.com/
>> as the api pruss_cfg_get_gpmux calls the api pruss_cfg_read and the api
>> pruss_cfg_set_gpmux calls the api pruss_cfg_update which are implemented by the
>> patch "soc: ti: pruss: Add pruss_cfg_read()/update() API" in the above series.
>>
> 
> What I read from the cover letter is that the series you are referring to was an
> RFC that predated this series.  Also from the cover letter, the second paragraph
> clearly indicate that two other series _depend_ on this series.  As such there
> was no way for me to identify the dependency.  
> 
>> This error is coming as the dependent patch needs the patch "soc: ti: pruss:
>> Add pruss_cfg_read()/update() API" to be applied for compilation.
> 
> Please provide a link when referencing patchsets.  That way we know exactly
> which one we are talking about.
> 

Sure, the current patch is dependent on the patch [PATCH v2 3/6] soc: ti:
pruss: Add pruss_cfg_read()/update() API
https://lore.kernel.org/lkml/20220418123004.9332-4-p-mohan@ti.com/

Thanks,
Danish.

>>
>> Thanks,
>> Danish.
>>
>>>
>>>>  	mutex_lock(&pru->lock);
>>>> -- 
>>>> 2.17.1
>>>>
