Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E8D4F839D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344786AbiDGPiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345069AbiDGPh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:37:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8B1E4C;
        Thu,  7 Apr 2022 08:35:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237Ec2mH000758;
        Thu, 7 Apr 2022 15:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CBSdSXcYVCgGrW/96f7IJTze/KlIc2NI/uEXJIDk7VI=;
 b=iIPUuwMuR8cdrsfgJN4uNNMelMcbGXjbZXT+Jk+OGOmxtByDCqttdYO96X8KzBv+uuKJ
 0cy4j1qWLppYbsDrKjJ0SKLntTaNztrGN+96C6YH1ijxL1TM1iKHxkGtsZfqjLc3W8uT
 OLBK95uob6sUR+AhEpv4UhK89a8mdrKdAuHGxDSxXcLvlaTFF96K54IZHTzSGJGZCqwc
 lKHlC5Ysm4YjRJN0cFbeeQGH50BShQtna6ZCAF7hYP52TA5ug+PO/3IteHYYy4L+LggU
 unq5td93d2NcXz1Z9yH/8v+1K0jFlFZDUYyWwJTBJ/+ndtDLx9IGKNAT9rzig32oOMDO WA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3sv9d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 15:35:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 237FG0jV036821;
        Thu, 7 Apr 2022 15:35:26 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97uwygey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 15:35:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCXBbCxXk68cWiggxzb74bOIuZhDICQtCfq82Ts0OgGp6+m4cxFx100DpxtcS/EzyX6S5APXex1YczaGqhIDMrxJCiWR1pB6JQYnaLiHkf2JQfpC2FFgZkQ5BYQK6HEpb/SFLwfdkqUqiV0DI9c6OXMgYI3COHLZEHdUWTLTfTXoIwyNapHqWAjzsaSQDecWkY5ENIkIeTWnL8/qVeQxGLDgmQBT61p3pSwM8VdNgKVUjxjWC6NMpJy2lkLi4zqPYNxrgcCvCJh/exqePtxPjf9ZF7UloO9ACS0dnQIZonyrDJ1bTXlyA0RqLwll4GMNsKnZPlXR34h2V3d/1waDsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBSdSXcYVCgGrW/96f7IJTze/KlIc2NI/uEXJIDk7VI=;
 b=eB1VGFb9G92onfGdosa0fgYx7dKtL3FM8h5S0PXcBFsXodht/SG3Spwpbsh76qpA0bP5BK3aEVgaf5l7h7bY8j0+syOc+N52uZ2XJDa/hLUc9MwSL8GuTBqUfN/tlGOcCBnbAITaUWGd3h+Kqtat6jEkS8c4hFvzm6XQmvWy8GwW0UlQU7o3LkL6K44U3NzSs5sXryqPdEO9O/+j0ARyReNk/hElVrIXfiREwumy52nLEGFEYAlXmY+vYu/E/f/GQgoQfULvHovkeI5yqaLmUMTolQK1bQrxDYmZ/6gfpRn7BMfrmgrm0UzEdQWmwlVHgqRdIUGz0QUo1eA3Z+5+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBSdSXcYVCgGrW/96f7IJTze/KlIc2NI/uEXJIDk7VI=;
 b=fjC470VngO68jjqbIPgO25Wqc8FDOIRejYe9J4KJbMXMRxQGPl3g2PgfkRayDpNP88An183k2Bwrfl/oiAFnqzlGL4D64S3T0AlHl9DgyzQAQ/wOEwfnGpj2mbdTU1wTmuNiVD2WWcUDR0hVG0cBiNXZq+Z9tAXY80+g9SbA3JI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR1001MB2186.namprd10.prod.outlook.com (2603:10b6:4:35::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.17; Thu, 7 Apr
 2022 15:35:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%7]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 15:35:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: runtime warning after merge of the cel-fixes tree
Thread-Topic: linux-next: runtime warning after merge of the cel-fixes tree
Thread-Index: AQHYSjpZ02rQX5R+XUqTnd+fShDo16zkd/wAgAASZwCAAAUtAIAABiyA
Date:   Thu, 7 Apr 2022 15:35:24 +0000
Message-ID: <F1B98786-A0C4-4907-9B44-7D13050237F2@oracle.com>
References: <20220407144524.2a592ed6@canb.auug.org.au>
 <F83867B8-2737-4850-83A6-13B95973A0BB@oracle.com>
 <20220407105446.186114c3@gandalf.local.home>
 <20220407111318.649f908d@gandalf.local.home>
In-Reply-To: <20220407111318.649f908d@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46f343e6-40df-4ed8-75ce-08da18ac3bbf
x-ms-traffictypediagnostic: DM5PR1001MB2186:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB2186125A351640BA397613B793E69@DM5PR1001MB2186.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VyoPt5tsrQjT3UL/j2AJApPYa7yAz2dUNAwBzB5aEJl2kpUbrwW842/Z68tC8krcT3rflUh0/kfolnHWsPwyMKH+iLP82aKi1nZXrLjWl1uRRpooS+S3tkk61tfcta5DLptbcu6MECqmjoM7QkNIkF1Har3AJGdypiCF97IIzF5m7iutZDHClgIyssy1mFNv7OGFjijjTGPRm1BzPFG9UtaNtaZbPCSV4wAXGluphkPMr5o/1IJHu0mbziOBB7WOjL1ZHa++sjVnYu6vxrg8HvvqEHMysuKsxWEunhhAlOetujG+RxRs3dzDCChd8LKOoXv5SHwKVshCBhXq6JQ84bF8ZkoCTJwIPlq0wU9I73C8n5JY/jE4zVqqvIKsfAjyILPnYC1NvJDNcp5YIT+x+CwD54bHRQBJ1YBJRkvE4hyhQTW2gR5Opw4frg16jKnxTHtcyVLtluTY5OC+gZE3NpEaPY/grIuxnT5DUdd3Ycy6LHtWtRv0405bsIS8n0RbgF1eHkJGdH2Kduy4XFQfS/T/xjWcs3+o323ZhFGfrETcC6ezOHgdSqFvp2M5OEYrlm0hbn8Sjqzg1vaO0qJOEtoiMvbOs3QNq7xLfXZg9LcOEQlesTylvTVtMfpQLspTUBb6Wmq1EfgT7hZxoD+PIbTdjTtjF2dCIrW6Ec+j1RCNWq9R7ikMW3dJ0gOPHDe02zWimmNxgJLCKpJqYziUmhLVQLSJ2HpTqBE1k1qKHZFDU+tdfxff35yKPJL66I1n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(91956017)(38070700005)(64756008)(66476007)(26005)(5660300002)(71200400001)(66446008)(86362001)(6512007)(4326008)(76116006)(66556008)(66946007)(36756003)(186003)(6506007)(2616005)(122000001)(8676002)(38100700002)(316002)(54906003)(53546011)(33656002)(8936002)(508600001)(6916009)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rWQNwNTphiGo7k/wvkkqniXNJjFnIC0G+HZeDzjGf59NInAoBytkr1FMGoPh?=
 =?us-ascii?Q?oteOoOPViVYtS471ORQknqFPYVfAvVDzUp9gOglPSq6nRiRCj9lrvKfT/9RZ?=
 =?us-ascii?Q?vLTVZv9mjl74XYeKSVLbxBavBdcQT1sEoENK1KW0JmTjTqMSSkr7umB2WFvD?=
 =?us-ascii?Q?xmyvFLp584F/BWFjvvEEtEtGhm5AMNejjDQdALN/YMnRHqyhV/PHKJupdiEc?=
 =?us-ascii?Q?iAGGbAuNSUFoTr/QgHYtNs2WwL0xp9OeqZacD4IQsHpsLr39QFF+dObtjOLj?=
 =?us-ascii?Q?mic9vEh91ci8VZDezYyYZRPeru7hvwdWixzGUDi9a+anTUzvWyDaHPNd4F1T?=
 =?us-ascii?Q?iGfEqmyMCeUnRaSmHFC+uDqOunHcynDf2s/yCxdHkSOlwJ/OhDaaLgp9Pa7b?=
 =?us-ascii?Q?7Kb473M+k5GiFXiEFgB/shk+joD3zxU8/qy4UmpBfd9FeDG1uu3zDDEC+m1I?=
 =?us-ascii?Q?Jy7ExcL8aV7BTNMKzQfLtu2v7RFYYq820gxEb/bH4dIShPXLcBcSnjP7jUuF?=
 =?us-ascii?Q?QSnlbqdYk+P2xTsTxHDOYWmnL9503MA+9J3xq3Z/b6lgMMCG/VEue57p1Sjs?=
 =?us-ascii?Q?/HA4ccKjO8zpYu7Pq+E9IFBoKWi2MtV8Vthwcmmw8aPgOPtS/OzuRLsqbyBe?=
 =?us-ascii?Q?6EmsMd8rpNq8Q78N2JQU+KV7mXhgxMpLH2v/JqKMtyzfYrq4PpCAq8D63Okk?=
 =?us-ascii?Q?xu+fZxtXMqQnX1qHukzIqb9XMMaPL1chbZcXKxQ3+y4l9EAxj3mYyutp4ewQ?=
 =?us-ascii?Q?5kpOtzJyRkqpayxGwzydv8cOwDyhlkLIEn+PhhAGiYddVSevMDpDWVcLp4Ck?=
 =?us-ascii?Q?am5V/u3khsrGcMj6MiVXARIJKNqnG5lVloBq/UdT1CIiWf+CUph/NbHVnA+5?=
 =?us-ascii?Q?pNPyP5arKEKB1qXcMK/x0g+yvfmIGnKpexasg5dRcXiZZ8cq5OK5Lk8xqpr+?=
 =?us-ascii?Q?z049JfHBmtCWwjCycneExQGnNYs6bU2OpyYmIvNQ+j/S2UUwikFk2gzR5oKr?=
 =?us-ascii?Q?RYJ7FS29S4Zm8fmswE2tiBvcnNcxXfTzkwzI2IWZA7CaxgsiXi5Yc5mObyFA?=
 =?us-ascii?Q?JapOe2PjJiJJzWQY3X98ZBUPjhoF4xAaucAVn+EhG06k8tUY7wZ8hgEk+9ge?=
 =?us-ascii?Q?rxAxVWVck4JkE1FMogRWIviuDl2CzWuPSCajACbZ317lqxbb9MtGMNaDfmbT?=
 =?us-ascii?Q?hsp7hfryJ0GDQMAlgJft5r+2g9zU6hSHRwi3i+Eqz1vIlkcmKUKrJhczuYiM?=
 =?us-ascii?Q?8/uvKKJgd+WLOz2EfM48UgyiGYE7yRk6QwmmRm1YsI7PEvG3+LlJEYsBzyc+?=
 =?us-ascii?Q?gFWQcyWajsIgrcTGik4ehnRFSVj97LVUQH5HEokJ6HgD/YJUP9bIOO5azXgq?=
 =?us-ascii?Q?8Hzieywv2fscxcuXoc+nMCDq1YX3Rr4GL3AwsrdYTMwELKLj0xgFeqJFlrTP?=
 =?us-ascii?Q?q/u1hEHD/F+lGTJvC6tFbmqjARUs8r/5irm3+LrjD0+79+DFvKO/fbGFOhBO?=
 =?us-ascii?Q?Ca3MfRAIKkwf8W3sh2idJ0LY0UaNbuRUDGs7oRB25C3UI81AWCEDttvezRDg?=
 =?us-ascii?Q?ashN0z9JXkPH3uide2m3p0ZlRosi1MhefZo9XAuEaBRomydUEUHFMFZ/Lu4T?=
 =?us-ascii?Q?6n8QDpTbjeuKeGEkNJ3b514LkE39zRUaQEjCOs9PYXja1zrJCJxgakKSMyzh?=
 =?us-ascii?Q?AUYGkLQgeZwwYVYMlMMUP7roztj2MzG/mJcwZkR7vzG5WjG2QjkEkoVmvEwa?=
 =?us-ascii?Q?kSV015r3iDC3RMTTEKYhZ50Qy54oid4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3005BCB86BA84449A1E5B346D41DC401@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f343e6-40df-4ed8-75ce-08da18ac3bbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 15:35:24.1253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7QXxVF37Dgs0tru3ONLtMvWCDhhSkJqzPcYPH4d1XXrmLCcnKS1W9kiWKICBQxmhfXlwkURxc/xOZdJ+zSorQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2186
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-07_01:2022-04-07,2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070064
X-Proofpoint-ORIG-GUID: oH3HyZ7RhCz64lkJD8ELY11TTja8Z4Nf
X-Proofpoint-GUID: oH3HyZ7RhCz64lkJD8ELY11TTja8Z4Nf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven-

> On Apr 7, 2022, at 11:13 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Thu, 7 Apr 2022 10:54:46 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
>> Hmm, I know we added code to handle "__get_sockaddr()" but I guess this
>> should also be fine for "__get_dynamic_array()" as well.
>=20
> Does the below patch fix it?
>=20
> (not even compiled tested)
>=20
> -- Steve
>=20
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index e11e167b7809..043b80f3e19a 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -392,8 +392,9 @@ static void test_event_printk(struct trace_event_call=
 *call)
> 			if (!(dereference_flags & (1ULL << arg)))
> 				goto next_arg;
>=20
> -			/* Check for __get_sockaddr */;
> -			if (str_has_prefix(fmt + i, "__get_sockaddr(")) {
> +			/* Check for __get_sockaddr or __get_dynamic_array */;
> +			if (str_has_prefix(fmt + i, "__get_sockaddr(") ||
> +			    str_has_prefix(fmt + i, "__get_dynamic_array(")) {
> 				dereference_flags &=3D ~(1ULL << arg);
> 				goto next_arg;
> 			}

That looks reasonable for present and future kernels.

We're looking for a solution that can be back-ported to stable,
however, because the patch Mr. Rothwell had to revert is meant
to address a NULL pointer deref that was introduced several years
ago. (Otherwise I would have just used __get_sockaddr() and put
my pencil down).

The simplest option is to take a brute-force approach and
convert the sockaddr to a presentation address with an snprintf()
call in the TP_fast_assign() arm of the tracepoints. Allow that
to be carried into -stable as needed; then in v5.19 apply a
clean-up that converts that mess into a proper __get_sockaddr().

That way, it stays my issue to address without needing to
co-ordinate with fixes in other areas.


--
Chuck Lever



