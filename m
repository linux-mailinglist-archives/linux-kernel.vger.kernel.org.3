Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE638595F08
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbiHPP3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbiHPP2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:28:47 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49EF491DC
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:28:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k17so5404524wmr.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Zcsr0zLVwDWpD4aOyB/+mgV1L6ZOxZ62xbZwJRua3jQ=;
        b=ROmZtQ5AmSReFeGawBFxX0jSVDeLRj3RA08SrAK+TIf/oQNDEU3HuF4udI4pbViIIX
         MxWh+lDCwPrrNFciPfBRiY6OX9xHhyROCb7QQ46V2hmlpxnzzOt6YGgHSbq9JXBYvjNO
         01JpW/wLrWCUkEV5Y2GNaQoE8CFy/k2jrb3FgQz3OEqTPCwqI43Zlun2kUVJtWMZfsja
         TLEug9ZzA7l/KB+61vrebvA0Wq7Jdn6ChQM9hXfSO5uxJ26SJZcdfCxVTlS9uz77Bi+O
         zMBBaH4O9oXHdBEgSMmeyE/35Refkr8YyxVmZ4fuo2GdkR8lQRgeNsb4nr7G/YzXYcnA
         ytMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Zcsr0zLVwDWpD4aOyB/+mgV1L6ZOxZ62xbZwJRua3jQ=;
        b=FcPtCbYvzESprxIscHONQZ9KLs7iPcWf6a8skSFRt8j9nQIObA4ITaz1yy/agMmjpA
         hrdkvDk+++uCexFUDYdMkd77j+wLB3NqPR5Itn7fYEvMb3lvPsZypbNlNqATeCfauTDs
         fLKPoR6pCLFW/ShI2kXK7v6i3s7qJsp0mE0ta5LsnJnoURdhDy062gzcGveE098FiPW9
         HQCQYiEUxjG6kQUN5GBDkrf0V+LG3cnr/2P6ui/6L3JDZZjcGy3UVr9mGBmeL7LiIpDS
         IAHIQ3Faj/TLXpLSvsmK+Zn9875iKjMVpx66dJ4az2K+jnptGEcirsgZNeEqM9dLiLOw
         8jlg==
X-Gm-Message-State: ACgBeo0iyn9PvUiOo7fU6HAqGZo16o3VkGfki+SJHyfNJx6ftDw/YQnX
        BInfH4d0WqPbRDkETnsT4wZpew==
X-Google-Smtp-Source: AA6agR4Kjh7p/2uag3SgXJRuP2YBnKlR3hjZD44R9I/rTpQNgmagnv9LEhpW+5PTiucmvOlYHvb2uA==
X-Received: by 2002:a05:600c:348d:b0:3a6:b4e:ff6d with SMTP id a13-20020a05600c348d00b003a60b4eff6dmr1682402wmq.95.1660663713289;
        Tue, 16 Aug 2022 08:28:33 -0700 (PDT)
Received: from [192.168.1.69] (120.205.87.79.rev.sfr.net. [79.87.205.120])
        by smtp.gmail.com with ESMTPSA id by6-20020a056000098600b0021e571a99d5sm10707879wrb.17.2022.08.16.08.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 08:28:32 -0700 (PDT)
Message-ID: <21a66361-5180-65e1-f075-2163bf46af08@baylibre.com>
Date:   Tue, 16 Aug 2022 17:28:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v4 3/3] counter: capture-tiecap: capture driver support
 for ECAP
Content-Language: en-US
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     vilhelm.gray@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mranostay@ti.com
References: <20220810140724.182389-1-jpanis@baylibre.com>
 <20220810140724.182389-4-jpanis@baylibre.com> <Yvkq9Hy+hxAPQd8J@fedora>
 <fe0fe04e-5ac2-e8c2-d568-0976ba085d6a@baylibre.com> <Yvuz9NUWXPhXqzeU@fedora>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <Yvuz9NUWXPhXqzeU@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/08/2022 17:12, William Breathitt Gray wrote:
> On Tue, Aug 16, 2022 at 09:58:10AM +0200, Julien Panis wrote:
>> On 14/08/2022 19:03, William Breathitt Gray wrote:
>>> On Wed, Aug 10, 2022 at 04:07:24PM +0200, Julien Panis wrote:
>>>> +static int ecap_cnt_function_read(struct counter_device *counter,
>>>> +				  struct counter_count *count,
>>>> +				  enum counter_function *function)
>>>> +{
>>>> +	*function = COUNTER_FUNCTION_INCREASE;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int ecap_cnt_action_read(struct counter_device *counter,
>>>> +				struct counter_count *count,
>>>> +				struct counter_synapse *synapse,
>>>> +				enum counter_synapse_action *action)
>>>> +{
>>>> +	*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>>>> +
>>>> +	return 0;
>>>> +}
>>> Right now you have a Signal defined for the ECAPSIG line, but there is
>>> at least one more relevant Signal to define: the clock updating ECAPCNT.
>>> The Synapse action of COUNTER_SYNAPSE_ACTION_BOTH_EDGES is for that
>>> clock Signal, but for the ECAPSIG Signal you will need to report a
>>> Synapse action based on the polarity of the next capture (i.e. whether
>>> high or low).
>> Just to be sure : by using the word ECAPCNT, I guess that you speak about
>> the
>> Mod4 counter (0->1->2->3->0...), don't you ? (2 bits)
>> Or do you speak about ECAP_TSCNT_REG register content ? (32 bits)
> Sorry for the confusion, I'm talking about ECAP_TSCNT_REG (32-bit) here.
> You should rename this Count in your ecap_cnt_counts array from
> "ECAPCNT" to "Time-Stamp Counter" to make it clearer to users as well;
> it would be prudent to rename "ECAPSIG" too.
>
> I didn't know that there was a register exposing the Mod4 counter value.
> If that's true, then define a Count for the Mod4 counter in your
> ecap_cnt_counts array.

There is no dedicated register for that, but it would be possible to 
expose this value
(when interruptions are triggered, we would just need to parse flags 
1/2/3/4 to determine
mod4 counter current state). That would not be very useful, though.

>
>>>> +static struct counter_comp ecap_cnt_count_ext[] = {
>>>> +	COUNTER_COMP_COUNT_U64("capture1", ecap_cnt_cap1_read, NULL),
>>>> +	COUNTER_COMP_COUNT_U64("capture2", ecap_cnt_cap2_read, NULL),
>>>> +	COUNTER_COMP_COUNT_U64("capture3", ecap_cnt_cap3_read, NULL),
>>>> +	COUNTER_COMP_COUNT_U64("capture4", ecap_cnt_cap4_read, NULL),
>>>> +	COUNTER_COMP_ENABLE(ecap_cnt_enable_read, ecap_cnt_enable_write),
>>> I just want to verify: this enable extension should disable the ECAPCNT
>>> count itself (i.e. no more increasing count value). Is that what's
>>> happening here, or is this meant to disable just the captures?
>> Yes, it is what's happening here : no more increasing count value.
> Okay that's good. By the way, COUNTER_COMP_ENABLE ensures the enable
> value passed to ecap_cnt_enable_write() is either 0 or 1, so you don't
> need the enable > 1 check in your callback.
>
>>>> +static irqreturn_t ecap_cnt_isr(int irq, void *dev_id)
>>>> +{
>>>> +	struct counter_device *counter_dev = dev_id;
>>>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
>>>> +	unsigned int clr = 0;
>>>> +	unsigned int flg;
>>>> +	int i;
>>>> +	unsigned long flags;
>>>> +
>>>> +	regmap_read(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG, &flg);
>>>> +
>>>> +	for (i = ECAP_NB_CAP - 1 ; i < ECAP_NB_CEVT ; i++) {
>>> Would you walk me through the logic for this loop. Is this for-loop
>>> intended to loop through all four capture indices? ECAP_NB_CAP and
>>> ECAP_NB_CEVT are defines, so your for-loop has i=3 and i<5; is this what
>>> you want?
>> In previous versions (IIO subsys), this for-loop was intended to loop
>> through all 4 capture indices
>> and overflow flag.
>> In this version, it has been modified to loop only for the last capture
>> indice (the 4th)
>> and overflow flag : yes, this is intentional. Only 1 event has to be pushed
>> so that the user
>> gets all 4 captured timestamps in a single-reading (using 4 watches).
>> But if I understand well your previous suggestion, you would like tracking
>> Mod4 counter value,
>> don't you ? So, I will change back this for-loop, so that it loops for all
>> capture indices (and
>> overflow flag) -> For all 4 capture indices, Mod4 count will be updated. And
>> event will still be
>> pushed only for the 4th capture indice.
> Instead of limiting the event push to just the 4th capture, I'd push
> COUNTER_EVENT_CAPTURE on every capture but delegate them to their own
> channels::
>
>      counter_push_event(counter_dev, COUNTER_EVENT_CAPTURE, i);

I prefer using only 1 signal if you don't mind. I think it's less 
confusing for the user.

>
> The captures operate as a circular buffer, so the user can determine the
> current capture index based on the watch channel reported and perform a
> modulo to read the buffers in right sequence. Alternatively, they can
> watch just channel 3 if they want to process only four captures at a
> time.
>
> William Breathitt Gray

