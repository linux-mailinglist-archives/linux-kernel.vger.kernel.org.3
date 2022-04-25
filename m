Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDE550E9A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244260AbiDYTmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbiDYTmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:42:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DDF112D8A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:39:11 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PJORtc023432;
        Mon, 25 Apr 2022 19:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=B8WDidiInKXoMa0NQYdlTGdwMS9bAhhkpIyWi25WW1U=;
 b=zHeOLNEsDrfisNxXa8P3vIPX0EQ2w8vG7UinvEdxYXwupZ/WveRNN8TqBHBnDHXhCNpZ
 RoieJIlal3Wit4liJ/otpzObzeoO0R6TIfy1It9vUaaaqud3AC4/qwxe8zBKbFu8a0y0
 4Kk+sVq9xfC0MJ1nFuB7LklDNgsGgW5rQB/rNVqptrX4SzaAlzspwAM7R1gziA2WyhMQ
 rU5uVjmHplbal6sl0DC673cf6/wHGUughZmu5syqWN+JxuWg1iloiO0l+/HhQu9pmAK/
 vMSoSr9VfEnruikxFilY6sA/Uo7hbajwxk4aU455TZUZ7Kv2E1SSpK5lgKwEw1qDvUGx 6Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yv31k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 19:38:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PJaQKC025517;
        Mon, 25 Apr 2022 19:38:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w21hj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 19:38:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giF0QNIkg+xeRV9MErpaMRa4KzfSUeZU5pPpOR2x7/eUnOZxfb2LAYc/ET3I2qsg0TGqK3PKLCTV7kqGEZExlR3asZav0Q1SwY4aiKyQo/QrfLPmj+A7QLd8EYr9qIUH9BS3DUi5QVPt+97t5ddJPp+ysD6vdoDIfx1faNLZaa3CkEii/6JoAK7HbfTtIVQmc+xWNNiP//67FXNtvHZnBPvYecXTdgZiTYcm+OIQD6X5ZU/V1SP7nv4xipQZGuMzHeaEY1VTYcPz9I51/9vTjg5YADrOGtrhUX8Y6+mHvaz4FU5lRXc8JIZIlAz45tCcCVbncykpC8Yuw5jwEl5J4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8WDidiInKXoMa0NQYdlTGdwMS9bAhhkpIyWi25WW1U=;
 b=NZVRxObxkhmsG2XE4agqhiEoYB8uK5VYRRwDs85e5yarsah1nTcPwGtBHD2RTY+mmJGY8dzrBt9acG/ghEnCPxzojhttTiDVTPB68mXY7oX4iXOFZ4gKFhG1l0r05qvAKRjfmDii2j80p5oe+H0Th9WjF8VIrSWCCn/4yZaqBC6piU4jJvtHdYatuPVhW/OWXZblN6Q5rY/DfYEabHVz0xtUIdRFdE+nn1k9HZ20SqOCK+Fjub22NqTGxLMfxYravROx1rOVKc0bA78kUodRQSWUSFieffGjsa/OnrFsA3G16EsANqELIosRnGE62OqENjDQ2m8JjDMFJV/RoGaY/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8WDidiInKXoMa0NQYdlTGdwMS9bAhhkpIyWi25WW1U=;
 b=hfpZ3VlUp4NUldyX6Jdc8LIXVuG6CpsFAKx5krh+QNGXO7mT0YVlAVkhzSNufsAXMzaoZokiBWKBc4yJGUpFVEncIWJKMoPbXqk4+P/s8hWW0TwC1wH/UjsHEV8pOFnAnzajyRCrZAUlwnnKCdLhhxxOEQUUy0y3ar7MCNmX4mQ=
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by BN6PR10MB2001.namprd10.prod.outlook.com (2603:10b6:404:101::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 19:38:44 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::69a4:385a:1e8a:453]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::69a4:385a:1e8a:453%3]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 19:38:44 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] ipc: Update semtimedop() to use hrtimer
Thread-Topic: [PATCH] ipc: Update semtimedop() to use hrtimer
Thread-Index: AQHYU5ANovQbEo/TBUSYkrXc/cSry60BEQMA
Date:   Mon, 25 Apr 2022 19:38:44 +0000
Message-ID: <8603345D-9AAD-43FF-B1DF-941BDA799DF5@oracle.com>
References: <1650333099-27214-1-git-send-email-prakash.sangappa@oracle.com>
In-Reply-To: <1650333099-27214-1-git-send-email-prakash.sangappa@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78294ef6-48c3-4ea6-01db-08da26f335bc
x-ms-traffictypediagnostic: BN6PR10MB2001:EE_
x-microsoft-antispam-prvs: <BN6PR10MB20010F99AB76CD032F46569DE4F89@BN6PR10MB2001.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jsv/Atk4DjlIQXmsi5QQVDnhj4o2xgxJkf79bdOTLA+hM3WWA3PFGlYKVoFg/R3VwRRfiiSxxQ3BNs+HEJ9+WASh+RSOlMW/4wSlSU1v5/eakUqW9g7RBRnITh7dyrJmwdoaXC81KTB+GV0yyTHku5ohT1qNLVy8hWmh4YBD1uNIUqAbvm1jTz6ET84IUyqPaQkx5DTd4bmPWduEnyYaDjnD2lM2iQGpUmEb5A5MR5F5A019QXVbB26M3lr2brBgBHol1GTwiAaKKj9O9D15UusysAez/adIuUC0ipWSQ09Algy0MzD9Z7dJs7CTHFzXIU8Op2TN3rYKevlfYa9xkTJ4u94MUs8aJC4TnxANKqRK9nF7Pxe8jD8hSr5Atsph/NMiylC/nPpp5Y30TZfinY9SYo3yLVmzalyrXGQLG79RDVFIPsA/EoTzF+l6HFkFPEj8Ib5GSnyn4//HgJ5HZ0z6VCi7Wo6sCwTnUNlCx1G0D5yi62p/ixyzzRZjHzsiCZXJIOX8JkxhEOqHTk991VKtEkgkyhotI5DHDYpru2+igjjDoGJERfpq9cvgscyV68t4f6BxyciYGQbjQw3sYM5ltrACrC5+zJSkxXSyFn9i6MjbUO/aRroq+E+tcJM24s80qvSvGIKoCt1qVu5ZbjfGiRBMaAH3w9xl7drtrrzACJ1g1r51xy2rITWGQBbLCqTlDm8Gwurb5GfD/XbMsPARPZHX3WqljwHG61uc/Ls=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(66556008)(66946007)(66446008)(64756008)(71200400001)(76116006)(66476007)(91956017)(6486002)(54906003)(38070700005)(83380400001)(86362001)(6916009)(38100700002)(122000001)(508600001)(6506007)(186003)(6512007)(53546011)(2616005)(33656002)(2906002)(5660300002)(36756003)(44832011)(8936002)(8676002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D7+arGn8dH/ftqPRlJVIy8swvKMdesN7sX0mEDPUV0gIG1tOOszPcoR3ui+l?=
 =?us-ascii?Q?T/AIGJZvxnFnJ6eSkWUXF7eATrW2m5qWwhLapl74/IfLKkQQyyJXVjaegF2B?=
 =?us-ascii?Q?mAaNwUJ2pwi7NX6empC/l0JalzCGRghrwLY08mCgT+0lIKHyWnuazIT98KKH?=
 =?us-ascii?Q?h8SV9l22AxUgrLIW33UZp3aCTByGvsn50GI6fAJM1SOVLf4ImeqccESMB/in?=
 =?us-ascii?Q?sg5/g2BjOSAOaL/u0uZsGhQ5IF1CbBrxLE5lwdnH3Ensgp0BNwOdyGeWbtY/?=
 =?us-ascii?Q?FXYekx3avoGdS3mFZgptSZ1a9cynjYJ7he64hMIerzgrt36jdkMJNBqt1w9i?=
 =?us-ascii?Q?wtUG0y9M/+lXQ73XPNKEPXlbW8RHlifdbea5s2CQNdsdtbvEyMjxB/SDbEiK?=
 =?us-ascii?Q?BCrx16l/X9sAqEl7tLAsufRbcPBdB+3PBgGHd+lbpNLnvTJnE9Wxo3pfq8i8?=
 =?us-ascii?Q?nRQJcS5kxoDtEXihZmtNaL1NOjczVop2y3jKopUix1fwrCFcRn05klLlVH2t?=
 =?us-ascii?Q?+PR/pa6yf96T8PkatkUzAgCwymUC68PMbCu78QFN74f5CF3XyPcw/9FxXwS0?=
 =?us-ascii?Q?dVRjos+ycIoR38/bx+bDj00ZkrDgPlpVBesA1Zw95IYgWdtog9hkDQstlBvr?=
 =?us-ascii?Q?PYWQ068Gj6NYLvMm7khZzWfswSqjZwG7k9F/N7AnQJBZD0NTQzckWziLs7EY?=
 =?us-ascii?Q?hMTXh/zwo/8NGOK4zyzCzzJfgOajJoqy3ov9ko0dQOLFCYdEbzz9H7lXgB3Y?=
 =?us-ascii?Q?h9EMsQU9DtO4gMmnm+NXsRj2LZzii1iBNKPQZPQrUhbuBPhKZlw0S4fyHSBw?=
 =?us-ascii?Q?tGBAN97AhcuNFEOprePj7QzKksKSEBBAbNFTIQS/p1vdfpKgTuHdYFrDfnil?=
 =?us-ascii?Q?cLNUZIScChlSek2HKUMEyOOtQLNcrbmAsCPQiVao0FQst9/1h12YzQG6BXUs?=
 =?us-ascii?Q?KpM6F7DfNitLMgwUw1kg4joDxqb2eRDakpJzSgQiHQkl2RLO/t12gb/UC+Fk?=
 =?us-ascii?Q?6K/ttC02e6HJ/1U7r9lN1Uyfm2f9/BTgPewEhfjue/dl3uOKwoqb7TyYvg7f?=
 =?us-ascii?Q?twfneF/+vqDJbNJfsPvv2ivn4IgWqs6H14FL2qhub62W7i3r/1xwsUBvBH61?=
 =?us-ascii?Q?UG1PM/tPYjsirX4S8K1eYVmsn93EX+Awgfu6OnIWKz6/uahgFqo6wT1BNRhs?=
 =?us-ascii?Q?DfxSjb1g9zAI4NKMZsk9o26kKbt0/nWinulJtwE2MiHlVhxn5oXda7mQN6+I?=
 =?us-ascii?Q?wAxF5bGNvySZXpEI4+G5bG3qpdhyuzGos3YZHhMOBTE7BABs7UAQ3pGJFQyC?=
 =?us-ascii?Q?ypGnysd45kEdq41qaolHPzqJ4o5hM3sf+9DKsoYmrb0p5iVnby+nRxxIjyjW?=
 =?us-ascii?Q?8vfA+aWj73PkI9re+EpEW7KCl53wllJYmCA9l21wAa845+OinKk0tsRfJw8f?=
 =?us-ascii?Q?x5c12uBNDltPyPz3sokW++Mk9XG89CcpHGFGdge7R6irvpr++UkT91FKRjQN?=
 =?us-ascii?Q?mOTvwzXseKggPsG87PCn0YIgeJfYPlqX/61J6G2d2J1QCl0dnUYQq085CKB3?=
 =?us-ascii?Q?7HzgnoxKbjV7Tc4wugsW3wFOvYmaYQRcfQpV8r/7Pjpkw1A/CE953ClHoy3Q?=
 =?us-ascii?Q?hRWEvXpONR2xyln9gtmE+mGU35cjYoy+3YRdo0h3GkNmhRI7whymYUQyY0qn?=
 =?us-ascii?Q?QixwcWxYdoJfyNNDRSWpuwZnQRG4Suuh2BeVtn+4psYnB5GpioZOv5E06rzp?=
 =?us-ascii?Q?EAcXMBKK0Vl9ZeiG/7OsQOhmuzzNL7NQgGaKBRYvjKfDSgzjYkB/5blLSNUz?=
x-ms-exchange-antispam-messagedata-1: YTvtJ4rsAYRkcg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CC465C0ED11BCD4AB8120972E78F2EA1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78294ef6-48c3-4ea6-01db-08da26f335bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 19:38:44.6143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 87opIjgdwhdvtiNXACzri9gOOLLTWKoOnP7Z5jFsv9oxiVNiMRfLxhXkMwbzE5ouVWsH4Ys4ZFoZBHYPQ99nQHGGca/NrrSPOo1oAQqguX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB2001
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_08:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250087
X-Proofpoint-ORIG-GUID: 3xeX-rexunNsV9ezazEdP-NwRfxBeUcu
X-Proofpoint-GUID: 3xeX-rexunNsV9ezazEdP-NwRfxBeUcu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 18, 2022, at 6:51 PM, Prakash Sangappa <prakash.sangappa@oracle.co=
m> wrote:
>=20
> semtimedop() should be converted to use hrtimer like it has been
> done for most of the system calls with timeouts. This system call
> already takes a struct timespec as an argument and can therefore
> provide finer granularity timed wait.
>=20
> Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>

Can I get a review of this patch?
Note this patch has been added to Andrew's mm tree.


> ---
> ipc/sem.c | 15 +++++++++++----
> 1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/ipc/sem.c b/ipc/sem.c
> index 0dbdb98..6cd1a1b8 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -1995,7 +1995,10 @@ long __do_semtimedop(int semid, struct sembuf *sop=
s,
> 	int max, locknum;
> 	bool undos =3D false, alter =3D false, dupsop =3D false;
> 	struct sem_queue queue;
> -	unsigned long dup =3D 0, jiffies_left =3D 0;
> +	unsigned long dup =3D 0;
> +	ktime_t expires;
> +	int timed_out =3D 0;
> +	struct timespec64 end_time;
>=20
> 	if (nsops < 1 || semid < 0)
> 		return -EINVAL;
> @@ -2008,7 +2011,9 @@ long __do_semtimedop(int semid, struct sembuf *sops=
,
> 			error =3D -EINVAL;
> 			goto out;
> 		}
> -		jiffies_left =3D timespec64_to_jiffies(timeout);
> +		ktime_get_ts64(&end_time);
> +		end_time =3D timespec64_add_safe(end_time, *timeout);
> +		expires =3D timespec64_to_ktime(end_time);
> 	}
>=20
>=20
> @@ -2167,7 +2172,9 @@ long __do_semtimedop(int semid, struct sembuf *sops=
,
> 		rcu_read_unlock();
>=20
> 		if (timeout)
> -			jiffies_left =3D schedule_timeout(jiffies_left);
> +			timed_out =3D !schedule_hrtimeout_range(&expires,
> +						current->timer_slack_ns,
> +						HRTIMER_MODE_ABS);
> 		else
> 			schedule();
>=20
> @@ -2210,7 +2217,7 @@ long __do_semtimedop(int semid, struct sembuf *sops=
,
> 		/*
> 		 * If an interrupt occurred we have to clean up the queue.
> 		 */
> -		if (timeout && jiffies_left =3D=3D 0)
> +		if (timeout && timed_out)
> 			error =3D -EAGAIN;
> 	} while (error =3D=3D -EINTR && !signal_pending(current)); /* spurious *=
/
>=20
> --=20
> 2.7.4
>=20

