Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B19054B8C5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 20:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343901AbiFNSiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 14:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiFNSiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:38:16 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CAF340F5;
        Tue, 14 Jun 2022 11:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grmRtHBF84N4ptkVePDTzAcwhTcXp8eOdS+n42gkQjMHvgVYoo9Wr43I8XEQnqacuf0vPnGzla2VqhWCY6va1vK6CyF+eNCw4RPNdg9MjMxz1w3z1kps/MuGkbcfRp5DwT3x2YbU09jVd6p3++RDkfD0rUm+D0eULAHSRrZrlWcfeZikWSOY4Kr+LR78mNJ9dfobXFI3r1BY0PHIXb+y3lOn+i52rtKdEy+DckJCCaF/QWv/HFYQnjV35xLgxig8ZlFtmXq6uOPMgtD8cDiLEQAP55bDKdE+fO0DbcG1f8QTN5bjG5hSw9IJEULf1rXDDfOkXKSAjMug8ZI/lkUHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmJ+tEcrrXUI1gQDY5X/TpDLFrCY5eIY17NP3wiKpZ8=;
 b=hr79jOGa4WiFSG7bEO+j9vQZtSQF906tZWoD0AaqGeambukXLc8yopDETD2wIXq0rcz/QTCzAQPEno2tqruonOiKz1V+2CQy8PIQtm+dHnqmQoqpxYV50U5ToX3EumwWs7Fys/HXn1PJTkX9bYme0wPzgNhxLX+JVbVXjcDDUoHH8KzmDoz1rS0hq9cilU5WPHI0hJHOtWxhMjCkpxCBAaawRYZFtwRe95GZBYZ70BrBvzgXSARs7Gb4K6vEPj1ZxlDeqTbOFvbDbWnjVkZ5ZbNqlgpLHPxXjJPojldBTAIfRIt7pzdtpbNODoWyqkpMUZSD3x46W8AOcDY1tzsxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=precisionplanting.com; dmarc=pass action=none
 header.from=precisionplanting.com; dkim=pass header.d=precisionplanting.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=precisionplanting365.onmicrosoft.com;
 s=selector1-precisionplanting365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmJ+tEcrrXUI1gQDY5X/TpDLFrCY5eIY17NP3wiKpZ8=;
 b=iUOJ0XLtwA5DBtqdmS1ounAgRtq2t+yGz7KnnU6VAYhcGBKKPMDTAZcIVuJ+RFza67n9+PevTaM8efPHtUsRtqcB+KS6ObO3jT9XQjdBjmm0E7VDkDL/fbufzTNF6oUM0d6HITxMSfzJh1WAg9WsfPJeU9iKqSJQjgW45yV4h/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=precisionplanting.com;
Received: from SA1PR22MB3196.namprd22.prod.outlook.com (2603:10b6:806:22b::8)
 by SJ0PR22MB2638.namprd22.prod.outlook.com (2603:10b6:a03:318::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Tue, 14 Jun
 2022 18:38:12 +0000
Received: from SA1PR22MB3196.namprd22.prod.outlook.com
 ([fe80::24b0:19e9:a42d:60b0]) by SA1PR22MB3196.namprd22.prod.outlook.com
 ([fe80::24b0:19e9:a42d:60b0%5]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 18:38:12 +0000
Message-ID: <5e95e4e3-6832-653f-0e7a-628c3ef35054@precisionplanting.com>
Date:   Tue, 14 Jun 2022 13:38:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ASoC: ti: omap-mcbsp: duplicate sysfs failure after
 PROBE_DEFER
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614155931.2706437-1-dowens@precisionplanting.com>
 <YqiyeM2JkDxLIKDe@sirena.org.uk>
From:   David Owens <dowens@precisionplanting.com>
In-Reply-To: <YqiyeM2JkDxLIKDe@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:610:52::39) To SA1PR22MB3196.namprd22.prod.outlook.com
 (2603:10b6:806:22b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45ade3b7-916e-4280-a11b-08da4e350904
X-MS-TrafficTypeDiagnostic: SJ0PR22MB2638:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR22MB26383F4A18ECF5E65EDF1901C0AA9@SJ0PR22MB2638.namprd22.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+uSeuRlOkLVQRelOsO+bY7fdiW2yryS62dBWtpqGkXFNCFqLK7Y/+CDMzucoaYNICnoGWguEd+SVAuQ3vzIni9FSXy9I2mmgIK11IhAaqGhHvQEpvQXXlQiz3JKYUxJVKTmEHs+PhPQyyXA7De4l0BJ5L2sB/sni6Lr8HbvgwUq+uxCywBnzW1ylpbcM2lIBskXk4mNNdIC8pehP09ec3UQaX05+IQDuWW/zKejaMlneRsH5DluaVsPh3g67NAnJlnvU3Gks9LH/HdyffIpnBGgDEfXTeC+GWsjo1TFHJM2f8USK3VevVXkV9iKz97cmaJNllOLpzKvRTNPChT7ZaXBzuWgQ3Km9LtBHf9pf11dck/UZ7SFjLukz8OfzyfSYJMJ38y3z/IrLk3xX+kEwBBZGN20xXIScX1otqtA6MtEbBaBhzmi6BSk+6sO5IOdBuObKQf0i4jL+3P5z6RqF0VXZFAu8jeb0/+r1a3AnN3oi7ER+2xYqEYJ5gY5XzYuo0IPpxE+nN5eEZaCtPGmBBfVCKyd1RUQ4Y8/jspjBurzZthdQWImClebwVCo9Nm1C47WiA8nXfg1VyWA5pAc/GxDdYjb1b3NCTP6KeY71N+L7YuxEt47Ovl7s3wwJqrHtBYypJ1ASVD7XXaXY4Hbm30v/NC93fobttS+tpSusAdob1Skv8ijyRRFc7FXfmX6Nq4/xONVgARhi2/jfFcnc5zoVNYNOPk4EmwRBnZn4K8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB3196.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(39850400004)(396003)(366004)(66556008)(66946007)(31696002)(54906003)(8676002)(2906002)(38100700002)(4326008)(6916009)(66476007)(86362001)(316002)(52116002)(6512007)(186003)(53546011)(508600001)(6506007)(2616005)(31686004)(8936002)(83380400001)(5660300002)(66574015)(36756003)(6666004)(41300700001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnlQNDJVdUxaQVhRSmlrbmN5T2h5VlllUkMwa2ttR1pnSHhiNWY5TmtEOGNn?=
 =?utf-8?B?U0I4S0haN0krOTd4NVlZVkcyN0NWYVJ6ZGRSVFhMaDloSGVQV21USE13T1lN?=
 =?utf-8?B?M3ZHMFdZa1hXcDlWZWkzeTJHbGJzWWU5YXVCNnlnZit1OGg4SlJZRHJaMmpP?=
 =?utf-8?B?MU52MlJvQXdLbmJQSjlNdkc2ZmRIcWdVcy9MS0tHamo4ZzRSNWhFSURRUDQx?=
 =?utf-8?B?WEdNZkRoTjloNENKOWpsSVhpc0p1bDhYQVBCc2VxQ1BFZUx4OWwrenJ6OUZI?=
 =?utf-8?B?dHMyemhsZWRjRHZjNXVETVRZZ0RMUUpiTjBRWUk2ekJlOFRIMm01QXdhOWIr?=
 =?utf-8?B?QTN6dVk4QlYxR2R1N25wK3VuUytIelpCMzl5bUJUTGdFM05HMVRuM21LdCs4?=
 =?utf-8?B?czY4ZjArcFBsaFNrU21yYzNxZnQzSHEzYXZsTGhhbkNGTlFlM2dwTTFkNTU2?=
 =?utf-8?B?aDdSTUJnWHBmNE40WUhYVHBSa2pMRk13MjR1UkZKR2pUb25pRk0zVmF4V2tL?=
 =?utf-8?B?aUlrVCtFZnZQc3N0MG4zOUNrSXJxbTFBVEdpdWtDa2VzWGZzYStvY0NVRkNn?=
 =?utf-8?B?KzdiM3ZVTFlnUkIwTkRNL0phVHppbmlZTVN2RG51UXRPdWxEOWt5Sm5OZ3Jz?=
 =?utf-8?B?czY4UVpNdGhtbFZPNHd3ZFZXRU1nMUhmNmlSZ0ozOWNuQ2NSbXphcjdHQXVC?=
 =?utf-8?B?dGhNZng0bWJXKy90VFRwT3V1MjhrTllaU1pyUGVVZTQ2MFZBT1hOVjVVVm5i?=
 =?utf-8?B?WlVPSENLU2V0Snl0ZG9pdTNJaU1qR0l6OGt2ZGkxZ1dkbzJUVEJxeW9tN21B?=
 =?utf-8?B?YzRJNkI5cFFKcnNNanZDMk5IN2tSVUhMYU4rWkIrT3dwLzdROXNNYVMxbEdr?=
 =?utf-8?B?Z3dnRkZ4SlZ2czNLekFnaFNwVnZJTzhRSGswQmh3VGFIV0hsVGtCTzJEWUY0?=
 =?utf-8?B?bW9HTzUzZ2swZmFSZnl1NERXQzF0eURZSEtvRmVzZS8xcHRDMmJDTlJlZXE4?=
 =?utf-8?B?UXBYM1BPb1RxQ1FaQVpkWmJuK0xlWnlGZ3BDak1FSVdyb2I3U3VNQ2RiNFpk?=
 =?utf-8?B?azFrek9QTUdDSndmNkw2V2pxc083ZTN4aGFtTFRuWmZkYVlzendwUWlUaFp4?=
 =?utf-8?B?NzlZZFJwYmhESmUrWllMalZETUc1TzRjVEtLOUJnc1dldGQ0R1M2ellVNG1y?=
 =?utf-8?B?aTZuL3c4VStQbTNTekg4OGtHUFRLTnBNbGErMC96ZzJwNThwKzgzZkU1UlMx?=
 =?utf-8?B?d2Npd3V6N0J3VC9TbXZ1WS9NOVVYRk5pdFd6ZFlRa2UyOU1DVHA3VkJFVm1Y?=
 =?utf-8?B?TEIzVkNhOEVWUDFRYzFFRWFNQ0VPY09iOFZWcWw2Z0kwaDRISEJLazNWS0Vm?=
 =?utf-8?B?cGdPVzBhUGRUaVNENk5rNENXUDh2T3I0T2hBZmpZdm1IUXN4QUk3MmJReTVY?=
 =?utf-8?B?ZjBCMkZWSERJWFhwZHpGVWZCWjlYUTFXNC9BNkNwNTBjNTl4dG4yWGNXTTN6?=
 =?utf-8?B?U0ZBalZpWE80dGc3cWVGakNQMlZXb1FQZmlOT0ZXSHI4QTdETGlIQ1ZEZVVt?=
 =?utf-8?B?THFzOFVWZUdnYlNPbms0aGRhRmk1aGkrdTZFRFZHU2RkaWlGSy8zV1FUdVpP?=
 =?utf-8?B?YVpObjN2WndoSWhyUFZ3ek9TQzRNQXhUYmZueFd6WDR3a1VuR1k0bnlNcWpK?=
 =?utf-8?B?K0JaYm4vRFZsU0ViN3lEeUkybHJIZ1U5TnZRRXR3d25hR0pDd21sWXdwa0Jn?=
 =?utf-8?B?RUZYaGVobnlUTHArYngrZHZRNldTVHJnNUFCN3lRUzRVQjRDakVaaDc0OTNw?=
 =?utf-8?B?SnU3VFp5UGJ1aWF3anlvUFJEZ29iQXZPa2NHcUVvYis0V1dlcWd2bE1qcnFW?=
 =?utf-8?B?TnhNWE1Vc1JiZXJ2eENCdndtN2VHdEFiL1FNQzdjSUN1VFVDSEl6MmhvV0lQ?=
 =?utf-8?B?YzY5QzVtVjh4ajBUbGhHM3gweVFJVTRxY1plODhJeTA3QnBaYldmWWFpSHMy?=
 =?utf-8?B?b2xrdm5TSldpNXM1TEVPN0ZWZHRkZ2s1bit5NVNMdWp3RmJLZEdnQlNwNU9W?=
 =?utf-8?B?ZU9jV010dTV0S1B1clBRNkVSMytrTG15V2tCR3NWSUFvV3g1UWpjL28wTHYy?=
 =?utf-8?B?YzdmZk53NUpmNjF6dFAybitya2hLeUdiMTVmcGJxV1ZPcEpNN2dJS2VRdzhm?=
 =?utf-8?B?Njc5MFB6czAyVENuNkpuVHJzaUhYckZxS3YwRFZMUXpab3lyVTVhdWZVNGRU?=
 =?utf-8?B?M0NlV1ZmaHhHZlZKdzN6WkRIWWpaMm14QXJUdjNrUk5UM0lTOC9MSmhrTlcw?=
 =?utf-8?B?NDlSV1cycWhCRDdhMzJETGs4OWQ0TmNEOG02UFFGWGZuRkExSDA5eDl4eGpZ?=
 =?utf-8?Q?LrMZbbnatN3MAu8w59hu6nEILzScrANubyjLHXMgJF56p?=
X-MS-Exchange-AntiSpam-MessageData-1: 4Nre4XxDNr+kR8PeWys/xvt3p4KXxouLqZdJelUL02f3UBsrJBUbh17M
X-OriginatorOrg: precisionplanting.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ade3b7-916e-4280-a11b-08da4e350904
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB3196.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 18:38:11.9440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa593af2-61f8-4d4f-988a-e9c4c02b7f57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQRen824crw2SaP98llASE0w84wkrV5XEC65hlqyGSSPRVfr6Tm7kXCMdhhN8y4Gxd/r+RY8qNRfe8VYpsB/qEswHhZLGgNKDb3wV9GNjJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR22MB2638
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/14/22 11:08, Mark Brown wrote:
> On Tue, Jun 14, 2022 at 10:59:31AM -0500, David Owens wrote:
>
>> The call to sdma_pcm_platform_register() can return PROBE_DEFER, leading
>> to omap_mcbsp_init() being called multiple times.  sysfs node creation
>> fails in subsequent calls to omap_mcbsp_init(), which prevents
>> the driver from ever successfully probing.  The resulting errors can be
>> seen during boot:
>>
>> [    1.749328] sysfs: cannot create duplicate filename '/devices/platfor=
m/68000000.ocp/49022000.mcbsp/max_tx_thres'
>> [    1.759643] CPU: 0 PID: 6 Comm: kworker/u2:0 Not tainted 5.18.0-yocto=
-standard #1
>> [    1.767181] Hardware name: Generic OMAP36xx (Flattened Device Tree)
>> [    1.773498] Workqueue: events_unbound deferred_probe_work_func
>> [    1.779449]  unwind_backtrace from show_stack+0x10/0x14
>> [    1.784729]  show_stack from sysfs_warn_dup+0x4c/0x60
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative (it often is
> for search engines if nothing else) then it's usually better to pull out
> the relevant sections.
Probably just the "sysfs:" line would suffice.  I'll be sure to limit
traces in the future, thanks for the tip.
>> +++ b/sound/soc/ti/omap-mcbsp.c
>> @@ -1403,6 +1403,10 @@ static int asoc_mcbsp_probe(struct platform_devic=
e *pdev)
>>          mcbsp->dev =3D &pdev->dev;
>>          platform_set_drvdata(pdev, mcbsp);
>>
>> +       ret =3D sdma_pcm_platform_register(&pdev->dev, "tx", "rx");
>> +       if (ret)
>> +               return ret;
>> +
>>          ret =3D omap_mcbsp_init(pdev);
>>          if (ret)
>>                  return ret;
>> @@ -1412,13 +1416,9 @@ static int asoc_mcbsp_probe(struct platform_devic=
e *pdev)
>>                  omap_mcbsp_dai.capture.formats =3D SNDRV_PCM_FMTBIT_S16=
_LE;
>>          }
>>
>> -       ret =3D devm_snd_soc_register_component(&pdev->dev,
>> +       return devm_snd_soc_register_component(&pdev->dev,
>>                                                &omap_mcbsp_component,
>>                                                &omap_mcbsp_dai, 1);
>> -       if (ret)
>> -               return ret;
>> -
>> -       return sdma_pcm_platform_register(&pdev->dev, "tx", "rx");
>>   }
> It's not clear to me how this fixes the problem, your commit message
> doesn't mention how?  I was expecting to see more error handling paths
> being added to unwind the sysfs allocation, or a conversion to devm.  As
> things stand it's not clear to me that the error won't persist in the
> case where we defer registering the component.

Moving sdma_pcm_platform_register() before sysfs node creation allowed
probe to exit with EPROBE_DEFER without needing to unwind sysfs nodes.
While this worked in my particular case, as you point out it might not
address all probe deferrals.  I can look for a more robust solution and
submit as a v2 patch.

-Dave

This email is intended solely for the use of the individual to whom it is a=
ddressed and may contain confidential and/or privileged material. Any views=
 or opinions presented are solely those of the author and do not necessaril=
y represent those of Precision Planting. If you are not the intended recipi=
ent, be advised that you have received this email in error and that any use=
, dissemination, forwarding, printing, or copying of this email is strictly=
 prohibited. Neither AGCO nor the sender accepts any responsibility for vir=
uses, and it is your responsibility to scan, and virus check the e-mail and=
 its attachment(s) (if any).
