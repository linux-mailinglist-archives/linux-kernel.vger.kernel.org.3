Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AE1492874
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244985AbiAROcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:32:25 -0500
Received: from refb02.tmes.trendmicro.eu ([18.185.115.61]:49197 "EHLO
        refb02.tmes.trendmicro.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238020AbiAROcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:32:23 -0500
Received: from 104.47.12.54_.trendmicro.com (unknown [172.21.10.208])
        by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id D0FD31021A156
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:20:52 +0000 (UTC)
Received: from 104.47.12.54_.trendmicro.com (unknown [172.21.200.248])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id C887410000486;
        Tue, 18 Jan 2022 14:20:47 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1642515646.986000
X-TM-MAIL-UUID: adf13b01-a532-4c7d-aec4-4f2a7c964559
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (unknown [104.47.12.54])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id F0F6210000319;
        Tue, 18 Jan 2022 14:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhJpzRENlFgTqXE+7JEBCyuOpeJxBtGWKqg5Oh7WSZvTwsXZsoRVboKqmVNBCsfMrOS6HfmoyXNt8vrMOQwJz8cECyHnecDmUgFAek27OvmnQW8HY0UZWRzoCuS1FjqTEOCrD60ZNcPJh2ACHpW0hQHunI0qj5A4g3uTafDcwroZDhGwWiEecXRuWvwjoAMPr8f2Aac/tRKLCc9KtjrTuyKZvAPq8KnRIBI39EpgQnxaZIS/iHoNDL9eCrrwqp6aCYr8Iwr6/ra58vo+SbTaKQ0uDIKXcOXJrVjXq+hFRDa5FSBB+lEf6SJJr5jvK0/zJDgbFH8eG/hM4IIrymWkjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsYUw/73+KaRXhtlPoaIHUYEF2JDTIOiHp1U4nRqqBU=;
 b=Pkun/xhwuJAeNNSL1d7uRTmGy6aalD0ruPIroC2wUb7P6bTlK+MXA3Mlm0DbPiQbFofhke/HOO+6p1IslfUCemtHYa5j9fF0adByiDq5bUluNUKvENhJCqlAFf5Lx4vfWDzq62jLupBuTW5g4VjM4kp8rhaub9dj1Nq25/l89NIBxkniwGkkcFJ0HKDKxrj2aY2GLWy7SrLkVu1ulJ0+6pFuaDdlfACFi55pZFjB6jB88fc2vwILEp2MtiaDt/Z1h8wrwv28cxVpM571Ab9EQMgAZeZTWpfte1SCItLwV0LipiSLg31mm3FqNSE3WROzhaH68MuBTkzhgKyYM8qZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <25455ab7-344c-10ec-318f-0681b88776ca@opensynergy.com>
Date:   Tue, 18 Jan 2022 15:20:42 +0100
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Igor Skalkin <igor.skalkin@opensynergy.com>,
        virtualization@lists.linux-foundation.org
References: <20211129191156.29322-1-cristian.marussi@arm.com>
 <20211129191156.29322-15-cristian.marussi@arm.com>
 <75e651e9-a273-5bd1-c7f7-37a072ad6608@opensynergy.com>
 <20211220213042.GL6207@e120937-lin>
Content-Language: en-US
Subject: Re: [PATCH v7 14/16] firmware: arm_scmi: Add atomic mode support to
 virtio transport
In-Reply-To: <20211220213042.GL6207@e120937-lin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::12) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 303ac27c-dfde-4d4b-ccb3-08d9da8db6da
X-MS-TrafficTypeDiagnostic: VI1PR04MB3263:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB3263FE0CD36A7FDD7EA2AE948C589@VI1PR04MB3263.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ucgAUNZGFv5teA/7r2Qof6PWG5HWRV7g1l4UOpuo6vU7ZwvpgmruTb7p7lkRHApPTZcv/jSOg6ZIAg2z0iT1B9Y0dYPynLJXcjTUTlRfTKrkkmjXDHrHX9+EOUSg90bZOupYuM0STZoTvwZOQ+Dc/wXX5TIim7Sgu9vWMNyCSQHE3IozEwa4u2APRBdNQgVvETTuIX6fUlVt1nSfswgi2XZD651Am3VlP1N5oq+DQsplpwq3UH128Yqrzr0LMfwW66l79vz4GpS6gBrU/svKEVgB2fEo8G3vXueDbL7CCdrXyEWxd4iimFNvDhBfG9+V6VT0f1oKCcpVAX8Srt9UGFDbkEwK4GJqEkdlXEwPpJTvA0rUniNOlvvjyIllSCPDjDBGpzRe8or5Pd5jGkFXfQNHDkksjOduJBD70+Y4DOcmNWSH8ljdwMKYVXjexhyWydNtoOCNrIFe+XyPDCR2ERgSXNplT/dOLNGLHpEbka3QViCR7xW9MroL78fTQfH3UlUz/fvT3YLgc+CwAd4E8WmUXP3wd5knd35M6ItFrW5QD2YXzWa6KPTZ+5qG4Q88BXapSFeox+fOp01wDbyh5bS1qOWF3I9g5wGAEjyjWy3pnNfOHZzeuqxxyCnFjUNanooBNX3tipAcXqIZCi4jWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(376002)(39840400004)(346002)(36756003)(66556008)(66476007)(66946007)(508600001)(186003)(54906003)(6916009)(316002)(31696002)(42186006)(8936002)(38100700002)(2906002)(8676002)(5660300002)(2616005)(31686004)(86362001)(7416002)(44832011)(4326008)(53546011)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alJaUDlqeElVZVZTdTlLQ2hPNnZTNDRPNFhCSHBBZCtEWnUrUm10RnpjK1Y5?=
 =?utf-8?B?ZVhseUpZUW5yQ3BhcnVsM0VSRkg5cHhHcVhFdldjMHZJdXVyQnlxQ1d3VkRE?=
 =?utf-8?B?U2pzcng2TEVPNjZvcGdqVDZEcGxhZXp5emNrKzhQY0hKSGs3L2p4REhkRTBM?=
 =?utf-8?B?UGM2OHRFOXRaSTNKM0ZnRE4xMDk4YXV0cVh5aUo3cHRMbGFEUjRMZGtyazlT?=
 =?utf-8?B?ai81ODg3SWNZQVFWT2ZYcnI1Skh1VU9lVjRRbXRpbnV3ampWVFFhTVRGdkwx?=
 =?utf-8?B?MS8rM0J3RER4aXZ6dXJtZDd4WDlkTWF5TGlYSEtabG9yeStyY3dJdmgzQ295?=
 =?utf-8?B?ZHAvbENJZXRuTHZyQ2FLVERPUDlmOHFuQmZYSEN1MTZUYkFhWkNSOFZtYXcv?=
 =?utf-8?B?c1p5dWcvc2I1akd0eXJDK0IzdUdKMXU1NXJmb0RRc1ZPcExVZXRCNWhMVGI3?=
 =?utf-8?B?MmNjaHl2NER6dS94SXhJY2REak12djRET0pHNzNvRGVGSEFiY3lTenNwVzlh?=
 =?utf-8?B?MUR4cWpwaHNZelZYdUF2NG01bGx3SE43V2d4akxUMDMxclc4VDV2bTJESytl?=
 =?utf-8?B?cG0wWCszejN4b2ZoQlcvUVRQMzhEcXA0azlvK1paZFg3NHh6NjNUMUFpL0FG?=
 =?utf-8?B?UlZ4RnBvWHQ0dExIOVN4cWtMTFcxVnRSdkZWbk85SVp0b3EzRkI4TkZXSnM4?=
 =?utf-8?B?Q1ZKRnIzYnFjejJEZC9NYnpmVC90K0U0UnJrOVpGNUZQN2hKQUxvSU8wZ2Rr?=
 =?utf-8?B?WkMzZlJhbHVHTklXeDU4ZTFoWDFQSnRGOHNmU2o1Q0NkQnNYRU8wd2h6SnQ1?=
 =?utf-8?B?VjROT0haNUc5T0NNa3R0U2h5Vi92TjMramdqWVJLT2toa0owTElNMTZSNjMz?=
 =?utf-8?B?dkhaYm04L2dYaGJwcSt4ZGpIZHkrZGh0VTY2RzZCeU1xczUvbEFRNzd6cG5w?=
 =?utf-8?B?U3kvVjR4MS9aNHBVUTRPMUdKOFJtZzlXNVk0dExCMEc0WmhVZ09ZdWFJVGt6?=
 =?utf-8?B?ZmNSdWdiN1Z2d1J2ZUJ0SjMvNmpGdnNxenBsOTYrT1Z0eW0yY1hVenJ4QVFu?=
 =?utf-8?B?eU93REluVzhVMjRMcWFRcy9oZ2p2clBCd2RVUURjMWwzMUtNd2pqNHc0eGpQ?=
 =?utf-8?B?ZTUvMGcrcEMwUDUyaC9ubDNwN2FtR1VOaVArOFVnT3N5RlgxVnQ3b21ES3E1?=
 =?utf-8?B?YjY0aU5ZaWtZdWJuQ1B0dlVhZGZsd2pIOWhvei9ZSnBBRjBhM3g2VXBYeG4x?=
 =?utf-8?B?bmZHbnpwRjdtVm12ZVM3KzJwc1djVjdDSDBkcmh1ZjdpbkNSY2xlVEM4dWta?=
 =?utf-8?B?RjJqcnFTdkdrazhxQ04yelpEK0hHN3BaajFRSVRFZGJ5dGp4cXlWYzRyZmR6?=
 =?utf-8?B?V2tISkpIZXVZeDdFTmJieERkYUkrZ3BzeVYydEYzR1kxQUxWOUFlTTk0MmNx?=
 =?utf-8?B?MnpINCtWK1ZoenpBRC9WMzFSVTJmYmdYbk85TnZnTWZ2UEVldHBMVGplcVg4?=
 =?utf-8?B?bzBNblQxanJGWThmZGljUU03Z3BTK0NOcXFOS0FyN1JDM2dYdEluaDBpQXVE?=
 =?utf-8?B?UHlrMFlhNjJNOFpmeTVBSjBuWm8wRXdwVVoxUzlnNy9oYlFhL3g1Tlg5RjlZ?=
 =?utf-8?B?QnQ1Z2x1OURXUk1QbTh6TldZZ1FYbklCbGxpdTUra0NpNVNPS09EZnozcytL?=
 =?utf-8?B?ejk1bVhSZU9CMjhFZWI4dGYzSHRFV3laRDdGdFJjWDk4SGFEaFJpbmp1M08r?=
 =?utf-8?B?NG9kZUY2a2RkSzI0WGY3MmJiM0lySW9jRFY5RTkzOS9MQ1BDbWNrdkJFVHpo?=
 =?utf-8?B?eGo4aVMxSFlVL2FkVFhNeEcyNkhuQ0c1SHhmL3J1VTdCV0FMSFJoZElhNjRX?=
 =?utf-8?B?SVQ4NGRwcXo0aHdRL2ZGMzlhMGk4bEYzeVNVSkRZbExhV1JUVlFZZkZQcXp4?=
 =?utf-8?B?RlgraitGT2tGMWcwR0xJNytwdElVcG5Kd1h3NjkyVEJUZDNWUkZ4ejJJUEhV?=
 =?utf-8?B?SlF6NjV6R0thdERvYUEyVTVTRm1ZQ2JURkJlNjBDT095OGphV0RhWlBRMGQw?=
 =?utf-8?B?Y084NGhVVFIrK0NKOEJUT292T1lVdUNUWWZwNTBQL1prdm5weDJVQmM1Z0Zn?=
 =?utf-8?B?YWlBWHR1RDRVaEQyTGtFN3ZJeGYxOTZLU3JNNjFkVnBhNzNZN3hNTmJJUGcx?=
 =?utf-8?B?VW9tLzVGUjl1U3FaTU0xTi9hcTkvTnlUeTFTOFpMZ3lLU3hCV2RaNzdEbTZa?=
 =?utf-8?Q?kZxABIdPcEaYXNruCHr9UCoJgE0rVZJBhuEEJaqOro=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303ac27c-dfde-4d4b-ccb3-08d9da8db6da
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 14:20:44.5796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zm2OcSlIRpcmNJWQTXED6tkC4Y0rlKG0VKgUk+EghOe/cj6UuWgGKWK3QwOiGj6nRKNi2IOHg/UgDb5OddsdHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3263
X-TM-AS-ERS: 104.47.12.54-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26662.000
X-TMASE-Result: 10--8.712700-4.000000
X-TMASE-MatchedRID: 6lay9u8oTUPmLzc6AOD8DfHkpkyUphL9TBkzBfi0S2rtVaZhog8bXKWa
        8SZmLplmhYmbqFQtIPyzNNmYcNQDpinqwKmU0oYz30kDaWZBE1Spvf+jmz45wzP3zxumESVR+O1
        7+tex20f4+veoc+y9mZaEPBC6VlA0jWSYNhI0bueJkf5qQgIh3VWiBZGwRpH+r3DiW2de5g8Yxy
        wUR/05sUqhGu5PwZpUNhKiZ9p2PIbGnnaYs88kQn84FZpy/6JVL7s3UWfpd3NBbp4JobErAipWM
        MWmA813QwxbKgvsebeF+VbDlO5n0zRFgrISksbyUfqR39ZbIlW++wkLapadd3/aLLx3UGLCaUXs
        6FguVy1UiXLTiA0nj0wjwpcgErNiuZxfSEY3BwIK4MBRf7I7pjgKqxRKlpUb6Z2vNpIov1yjxYy
        RBa/qJQPTK4qtAgwI9TBysq4cSBZWdFebWIc3VsRB0bsfrpPIx1FPlNAAmcDvD4mWUxMZuZodo3
        jxZzTs51/EV/AZK4Gok/31kuOv2p6oP1a0mRIj
X-TMASE-XGENCLOUD: fd656f75-c27c-4089-a2c7-b8483c13ae12-0-0-200-0
X-TM-Deliver-Signature: F684A258DBFB234F7F7C6D388507FBBB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1642515647;
        bh=rYvG3VWRBp9EJN6DqkOuRU4U4gafkXZUzilSRAsR1TA=; l=2193;
        h=Date:From:To;
        b=H0MilpCTOMq+lowAWjkY6RsSfUAjtZ/FOO93ojORStamXom2tqsDRGphDezdc9Fa2
         1QFwtfItH258R8E92jRBP1SvwEr4yVbKLkj7eutF+S8/5Naa6fNcLBjxlroTx1svyw
         koALAgBMiWTJwrMkxJ4fi2ZOz9cYIGEXE/rcOxxuZVTvh5ceZvboTI9k3rITI26XlM
         fgycaGlaUZKk+nUN2kPtfll/15oKEhJ5zogWhWlJLNO1WpmZM2mLTIJpvAxgl0wBga
         6hNv35FT2xxrfS6WRrC4FzZfUyCYPKXt8zWgeINZgJOpaINHx7sQ98BUWtGdpBf/5R
         ZMEEHuLX1vnfw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.12.21 22:30, Cristian Marussi wrote:
> On Fri, Dec 10, 2021 at 01:12:18PM +0100, Peter Hilber wrote:
>> On 29.11.21 20:11, Cristian Marussi wrote:
<snip>
>>> @@ -65,12 +69,22 @@ struct scmi_vio_channel {
>>>   * @input: SDU used for (delayed) responses and notifications
>>>   * @list: List which scmi_vio_msg may be part of
>>>   * @rx_len: Input SDU size in bytes, once input has been received
>>> + * @poll_idx: Last used index registered for polling purposes if this message
>>> + *	      transaction reply was configured for polling.
>>> + *	      Note that virtqueue used index is an unsigned 16-bit.
>>> + * @poll_lock: Protect access to @poll_idx.
>>>   */
>>>  struct scmi_vio_msg {
>>>  	struct scmi_msg_payld *request;
>>>  	struct scmi_msg_payld *input;
>>>  	struct list_head list;
>>>  	unsigned int rx_len;
>>> +#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
>>> +#define VIO_MSG_POLL_DONE	0xffffffffUL
>>
>> virtqueue_enable_cb_prepare() returns an "opaque unsigned value", so
>> this special value should not be used for .poll_idx.
>>
> 
> Yes you are right, but looking at comments in virtqueue_enable_cb_prepare()
> and virtqueue_poll()
> 
> /**
>  * virtqueue_enable_cb_prepare - restart callbacks after disable_cb
>  *
>  * This re-enables callbacks; it returns current queue state
>  * in an opaque unsigned value. This value should be later tested by
>  * virtqueue_poll, to detect a possible race between the driver
>  * checking for more work, and enabling callbacks.
> 
> 
> /**
>  * virtqueue_poll - query pending used buffers
>  * @_vq: the struct virtqueue we're talking about.
>  * @last_used_idx: virtqueue state (from call to virtqueue_enable_cb_prepare).
> 
> ... it seems to me that is exactly how I'm using it, and moreover I
> don't see any other way via the VirtIO API to grab that last_used_idx
> that I need for virtqueu_poll.
> 

I meant to say that the VIO_MSG_POLL_DONE special value should best not be put
into the .poll_idx (since the special value might in theory overlap with an
opaque value). Another variable could hold the special states VIO_MSG_POLL_DONE
and VIO_MSG_NOT_POLLED.
