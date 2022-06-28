Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C8455DCED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241960AbiF1HVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239944AbiF1HVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:21:32 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940422CE17;
        Tue, 28 Jun 2022 00:21:31 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S11cMf020483;
        Tue, 28 Jun 2022 09:21:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=vrWQmttz471sHMcNs5New/QqP5VqrpeycGKyDRxFuXY=;
 b=pqL1gw129gHc/+EfyrjHYyJnva20mjgFlZoccs1i0eS8PFtns+Tmqt+RNNIt1w6DSd0D
 AftgGD14+iRqV/DafxjzPQPnmFaTXO2EWhEoTDBz12T+V+3Au9D9eNORESqTyxXrjanb
 fXH1eZ9whgH6r0k75jLsk65g2fN5EfCV+kRIYssJufv0QRXvNbHLUF0aF86QRIKIZ9WW
 zYBCZi5M4XLO+vJ6IkM6hscFk0yRoUB1otVHxxBgfONDdZ65glQ5WZA2XCPLMPjRVZyw
 ZWwZ4bO9aqqA6kQJK/GZowpdtKOgjtHASvXemup4PO8E8UxJyqzn2lIqCweMo8r66Zbb 7Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gwqg9ggac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 09:21:16 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5733710002A;
        Tue, 28 Jun 2022 09:21:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4348220FA3B;
        Tue, 28 Jun 2022 09:21:14 +0200 (CEST)
Received: from [10.48.1.102] (10.75.127.47) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 28 Jun
 2022 09:21:13 +0200
Message-ID: <bd35eb19-cfda-4799-1ab0-0578d3c79466@foss.st.com>
Date:   Tue, 28 Jun 2022 09:21:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/4] usb: typec: ucsi: stm32g0: add support for stm32g0
 i2c controller
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     <robh+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>
References: <20220624155413.399190-1-fabrice.gasnier@foss.st.com>
 <20220624155413.399190-3-fabrice.gasnier@foss.st.com>
 <YrmtzDfFm17PFl2r@kuha.fi.intel.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <YrmtzDfFm17PFl2r@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_09,2022-06-24_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 15:17, Heikki Krogerus wrote:
> Hi,
> 
> On Fri, Jun 24, 2022 at 05:54:11PM +0200, Fabrice Gasnier wrote:
>> +static int ucsi_stm32g0_probe(struct i2c_client *client, const struct i2c_device_id *id)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct ucsi_stm32g0 *g0;
>> +	int ret;
>> +
>> +	g0 = devm_kzalloc(dev, sizeof(*g0), GFP_KERNEL);
>> +	if (!g0)
>> +		return -ENOMEM;
>> +
>> +	g0->dev = dev;
>> +	g0->client = client;
>> +	init_completion(&g0->complete);
>> +	i2c_set_clientdata(client, g0);
>> +
>> +	g0->ucsi = ucsi_create(dev, &ucsi_stm32g0_ops);
>> +	if (IS_ERR(g0->ucsi))
>> +		return PTR_ERR(g0->ucsi);
>> +
>> +	ucsi_set_drvdata(g0->ucsi, g0);
>> +
>> +	/* Request alert interrupt */
>> +	ret = request_threaded_irq(client->irq, NULL, ucsi_stm32g0_irq_handler, IRQF_ONESHOT,
>> +				   dev_name(&client->dev), g0);
>> +	if (ret) {
>> +		dev_err_probe(dev, ret, "request IRQ failed\n");
>> +		goto destroy;
>> +	}
>> +
>> +	ret = ucsi_register(g0->ucsi);
>> +	if (ret) {
>> +		dev_err_probe(dev, ret, "ucsi_register failed\n");
>> +		goto freeirq;
>> +	}
> 
> If there isn't UCSI firmware, then ucsi_register() will always safely
> fail here, right?

Hi Heikki,

Yes, in such a case, the first i2c read (UCSI_VERSION) in
ucsi_register() will return an error and safely fail here.

Thanks for reviewing,
Best Regards,
Fabrice

> 
> 
>> +	return 0;
>> +
>> +freeirq:
>> +	free_irq(client->irq, g0);
>> +destroy:
>> +	ucsi_destroy(g0->ucsi);
>> +
>> +	return ret;
>> +}
> 
> 
> thanks,
> 
