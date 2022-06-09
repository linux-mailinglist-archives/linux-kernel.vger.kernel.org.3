Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE6754458F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238299AbiFIIVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiFIIVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:21:48 -0400
X-Greylist: delayed 2867 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Jun 2022 01:21:45 PDT
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9C41D5017;
        Thu,  9 Jun 2022 01:21:45 -0700 (PDT)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 258LLenm016132;
        Thu, 9 Jun 2022 00:33:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=2uzorbrvOGtO0ZpIYxzDoR7i+2E4yq2v2oaV8ETLnEU=;
 b=X3BvMs/wmFjsSUxGcD8cIsVIfEPK3Xr6ez64D4QZind3t2PzOuToUNw2Tht6E/DxkWWB
 zRcS/tjE2WahJjk9kVpOuqrukyIWJFEH7X0wnujMZ88GRuT4skZzHMdmkg7tbboSg9SG
 Om75FQlXyzw8rhu4iEgICBGJmui6WLIm8vKRoqEXpqSjoudOJt8vkFyDjYY/Lk/MdJJV
 S2CaqOhpSABRVZlrPPSHHG11Pd7azm83HWEt093oXNV+gEOz+7N0Ug1qn95D93TpRl1l
 opci9Dre1XOZ6R0+ak/jttvvy+vXN5n4+818c8vwq1IT0/X5XQ+Us/nPIbHIGCaQxMNf 8w== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3gg302bcyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 00:33:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjHiyNVIPv+U5VLssBd8QA0/5ezv4tUlIGP5/hkuM6Avfo8sbU9ncLxZcLSHujU7uiJdi3HAd/LtkI4G8zoIvkvqa0Nn6d1QsMtSo9PCpiAUMPTPbW27FxQEfFOShzlogNVmVCcatvz90kJTrDwTySDJMUgXrMDalZKFH9ye0SiUvc3qaI2zuMXWZqyqAyYbby5yXvT3AwHvHXAmnxmX8M5ubFAuwqMtXWB6iILIhdXBZTNqOjOEfxAx7AAjjdjVevYo2alnq5jzNfu836Od5F3dhiqVh4Yjwk8jB2wiRr48AkT2pNo6IeyushWAmQBcMCDtSPds1lXs381V4gQluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uzorbrvOGtO0ZpIYxzDoR7i+2E4yq2v2oaV8ETLnEU=;
 b=lCeyRyo5yXXJ9pYfeFojDJh/xoIVY8NbjNii3RK0O0VhrurvUQHcN1Wqd/SzFJqAW1FuRgASX/6tUQHmf5CgxlgV1Up2gXzSvxC7sU03Glb/lpaRyzCA1qqSEZxcQtWP8Dg7odezZlxPKldJrkw2oGl6UDymr7npcXpsaEZP/KsBy3RFNUvkKYN1VOg5hae2Vj2ZvYF6vvNbLXDP5fyLpIoh5kjhWgirWtsRFqfWYil6qKbINaFaEikp15UXNtmvOo0H9eTfflNPgVg9zNh0xZdH+x4Y+wb1cUi9cSLkjKiTr2ltGyMkOrFWp9XCJ5rCwIQcHG7yNx2Oih58B+3xyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uzorbrvOGtO0ZpIYxzDoR7i+2E4yq2v2oaV8ETLnEU=;
 b=wu/OxI/+laJwzBKnr4qwut6mr4MgchwsJ45ddCavAomnhx+yZ6v6WHa6icqxXicuLAnlhDGRlhm9SD6O9pTibI8vWi9cjHKhd2IMv/Iv9LfnbBt3Fi2g2Ldt96G1K/XQ+yZS0XAF9qFEEIbIE/jQr8e0viJ7pouU3OwQyUnWB94=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BL0PR07MB5043.namprd07.prod.outlook.com (2603:10b6:208:4c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Thu, 9 Jun
 2022 07:33:38 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::10bb:b62b:9042:870f]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::10bb:b62b:9042:870f%5]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 07:33:37 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     "3090101217@zju.edu.cn" <3090101217@zju.edu.cn>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jing Leng <jleng@ambarella.com>
Subject: RE: [PATCH] usb: cdnsp: Fixed setting last_trb incorrectly
Thread-Topic: [PATCH] usb: cdnsp: Fixed setting last_trb incorrectly
Thread-Index: AQHYe6ZQ67fRenHLO0e4DnN78WOKXK1Grcgg
Date:   Thu, 9 Jun 2022 07:33:37 +0000
Message-ID: <BYAPR07MB5381C83A4E06D4972E6874A9DDA79@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20220609021134.1606-1-3090101217@zju.edu.cn>
In-Reply-To: <20220609021134.1606-1-3090101217@zju.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNzdiY2M4ZTQtZTdjNi0xMWVjLTg3YjAtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XDc3YmNjOGU1LWU3YzYtMTFlYy04N2IwLWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iMTkzNSIgdD0iMTMyOTkyMzM2MTUwODQzNTg4IiBoPSJSM09SZFRFWFhkQkhOSGxyOC9WalVBa094NzQ9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da16f729-1923-41e9-91eb-08da49ea5e38
x-ms-traffictypediagnostic: BL0PR07MB5043:EE_
x-microsoft-antispam-prvs: <BL0PR07MB50437CB6160BFB52D4AC1F29DDA79@BL0PR07MB5043.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mOmO1exR0EQ9bTAgRuUpWFNxUu6l/6Q7Y5A5j3JodyTwwvgr8wMEzjryGxyCNZy2tuyNy9vNzeqPxYys488WxTpSsitqTiIjSfG9+HTtfG9uEycfq8FOCS3ElndQEHrYD6q9EKpBuuXzdl/yNyfg75IIpKfUniE/FbbEHDpCA+RmF0jA9k04apUZf0aQr8etz7zYE80lnjIGDm2qsWIm7O50gVlZgs2RXof2+bhEe1dcdJAu81jatBvhH6hbNtTB4kd76eflXTCfeeopdGh2xG4/NnpgG3qz8Q8aeW4O3lG0cAjDOFWcP3lOetw/DgtvvRMjHYHszEacssNn4m3BGuFxHCD8OcWns1tZq7qkTOcI6Spgo2A3z31hPHTWcueD2i+ueWzDXjvVGjKF97AR0uTptINL8GPHe9gSDoUSERJ+X4KzQxTf/2+dCLioWaBT8Hn3m/33l3SY9s23Tim2u9cggbMAx8Y32sa0LeRFyR9H6sChGt/GBaCYrVBmhC5NuREns3IrnMM9YTQSqChOoHuH42R63CCN17rbT245BOFdGOEPh81b0gEXBIyGws7VMifpPqiEhtHN7uYeLilY1Mhw67fJxpVeeV/lmF1Ku85yHM8DnJs7lFYAmWQh7K4jG9OZ3LVLgAODUV+eRTDVmKbkysf2GETqoOA0r6HqAjC0HyWmlpWf/ICibxhWDvZo08KMkNOsme6uBLdRVbJFxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36092001)(76116006)(38070700005)(86362001)(2906002)(71200400001)(316002)(186003)(33656002)(9686003)(508600001)(83380400001)(26005)(8676002)(66476007)(66446008)(66946007)(4326008)(5660300002)(64756008)(66556008)(122000001)(6506007)(7696005)(8936002)(55016003)(54906003)(38100700002)(52536014)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sMb35eziCQAXA3/pko/QYXanpFOoCJFNnIqctKKSTr7RKwIFB6IXUV2T+jTA?=
 =?us-ascii?Q?qVyre+nivNxZz+D0QRk1roKDDJTnFhTPIuA1BqIn6gca60X57BvEHeR/CAv+?=
 =?us-ascii?Q?UHu/22ihk9f27fhugdLHUyVyx1JmRVOAGwY7gYWY4ZRzeBMCkI/w7aYa2iVQ?=
 =?us-ascii?Q?Zus223nVb9OhoZsYgnn18EdDXEKP6ULtT3NEYZOlCIGHh67lfLndZ4/D6jeq?=
 =?us-ascii?Q?TVpKAqh+FCH1f0Ey2TLNTcMJwprklmoXvgdpmK55HEi8szDy50d2uUl73TXR?=
 =?us-ascii?Q?cSVkVbRVebAdYmt+iGmyPs3v6sRzXPHJMG5iRt/UBGG7sedcyDe1WVKrc5EG?=
 =?us-ascii?Q?i4RDL7wr0F6hj+IXhaIbg9ynwJfMY7ZXOGXeoKAucOthGaCQLYuIVefx4GNx?=
 =?us-ascii?Q?X/xXU/yxuc20Pj1PvED+fgKoUbSzYw4xOAYWE7PS+fFGYXJPHcWMd6xYkBwX?=
 =?us-ascii?Q?jDZZnfYNDSprkUcOKx1FPXRCUwZX7HM1bXVDY7R+vV9LUadpBWu2qbvdiltv?=
 =?us-ascii?Q?DIQt3Gl7hAv6KwKuPp3idBzimcm3PgvhgLbKvoNWT7qWgo7j4NqVI9U6RSTQ?=
 =?us-ascii?Q?OVfbUNFZD6tferTc1siaPEtpkNvl68MOf3RORus21gsU5Ri41qJBqTgbYmur?=
 =?us-ascii?Q?H5+Ee7G9muiJbSCXEZzLS9NtR+Cw9lX4rzCw3QsP/OCr+y4kfIoJQ9FI6GdA?=
 =?us-ascii?Q?DzB4l35WP25efPtqsN8xiyX0a0NFQdG6z88FK4/KVM9Whr1zKFGtnvnLQDri?=
 =?us-ascii?Q?/2NEVprsIuh6BA5Hs4CVQz5jHbCs3oniIt4jo7q3mVa40U2Kfu8pYmgObwB7?=
 =?us-ascii?Q?WDaPBKMdx56l972LtR/issDamwLh+Hoc1a7uyEmlZvEhbsxgtz1R7MtUkW+d?=
 =?us-ascii?Q?G86rR2st/OvNu7uE+HMWP6fzn9529nQfwBWbs8CBL0fKYETGVB9AHdDiNGHb?=
 =?us-ascii?Q?Vnl3I8254k4EKV2s3yd9KxjgF++gBbohnkhNIzHGupdKgC6NuffRwcz5yoX+?=
 =?us-ascii?Q?yvGqtwAqLDCAlUc8gEDTJX1qym+tXJyC+K9uEJJysF78alvEo0+O06k3iNdz?=
 =?us-ascii?Q?zeJBF43yDAAW5RS6VgjS4bXtiWy2nHnkEtzf9j1Un0TwnsEqfPF0vZ0/dj88?=
 =?us-ascii?Q?LPhb5cgJ63ABQYD/IPMzlx+lw0Ztf4906M3DzPEceAjmOEBrRB9Zp/FyQYIM?=
 =?us-ascii?Q?bRYx3DE03nbxgUFD8AfydTtbr3PUapfcbRJ/bJMrxBA6DCR1Vn42bVRBREwU?=
 =?us-ascii?Q?CWxqIrJGoDovTHlcSlpoz0I6UWY3hgM9hmyzIbvQNBADrAji4/+BXdoYE34G?=
 =?us-ascii?Q?v5mNIg4Zd3AIa3oeu5i7OHQjA5V58TsSXkNn24HtcomvfKIV/OJIgtXSg12b?=
 =?us-ascii?Q?qPRPfXbFF/EtC79+vlOL7IjiOrqNjxNa62ufCsVyTa5AFlZWIXvE0B5aBZHY?=
 =?us-ascii?Q?bexppCE8o+gsmGgLPxq6kyjkKRKrK6VA3ifxV9BZgRV7OdgJ66JyefnR21W+?=
 =?us-ascii?Q?Q7JU7y3ZyOWb2HXWgRfnvdasI8Z5jwp3BOUfrcbL2wL+yogeGeMIZj23sKgq?=
 =?us-ascii?Q?7NLnsZEaw43fRNVWfw20RBckT4a/DrY/pmLUTl+rf1uEqc4/kqCvXh7A9sAw?=
 =?us-ascii?Q?ToD0moDd816Wc56P+UmYXp/YsGNvFk1cGYRg6SQv/NhFhmwjrO86d6uX0956?=
 =?us-ascii?Q?CiskFINsoiiXGAeUSvMuEkFKLT172F2UB8VqZ7PWErV/RAPrIfBhcLTr6ZHC?=
 =?us-ascii?Q?cEHCj/JdKj9t52iQA2d6EwZwW/+CM7o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da16f729-1923-41e9-91eb-08da49ea5e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 07:33:37.8130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMPR3NAFKBq/F8Ew5im8ftswMbrdboGP/TiKKRKE6qMbmmmNlu3qApaQ2NLyJ6n7GnLn8xsYcK5X0OOL5oEQAJx8zO1X/aJsCZ7Pz5BcikM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5043
X-Proofpoint-GUID: -g-W6EXzFJ4Ko4H4E-AZTOEwsbTAOF4q
X-Proofpoint-ORIG-GUID: -g-W6EXzFJ4Ko4H4E-AZTOEwsbTAOF4q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-09_07,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 mlxscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=636 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206090030
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>From: Jing Leng <jleng@ambarella.com>
>
>When ZLP occurs in bulk transmission, currently cdnsp will set last_trb
>for the last two TRBs, it will trigger an error "ERROR Transfer event TRB
>DMA ptr not part of current TD ...".
>
>Fixes: e913aada0683 ("usb: cdnsp: Fixed issue with ZLP")
>Signed-off-by: Jing Leng <jleng@ambarella.com>

Acked-by: Pawel Laszczak <pawell@cadence.com>

>---
> drivers/usb/cdns3/cdnsp-ring.c | 19 +++++++++++--------
> 1 file changed, 11 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring=
.c
>index e45c3d6e1536..794e413800ae 100644
>--- a/drivers/usb/cdns3/cdnsp-ring.c
>+++ b/drivers/usb/cdns3/cdnsp-ring.c
>@@ -1941,13 +1941,16 @@ int cdnsp_queue_bulk_tx(struct cdnsp_device *pdev,=
 struct cdnsp_request *preq)
> 		}
>
> 		if (enqd_len + trb_buff_len >=3D full_len) {
>-			if (need_zero_pkt)
>-				zero_len_trb =3D !zero_len_trb;
>-
>-			field &=3D ~TRB_CHAIN;
>-			field |=3D TRB_IOC;
>-			more_trbs_coming =3D false;
>-			preq->td.last_trb =3D ring->enqueue;
>+			if (need_zero_pkt && !zero_len_trb) {
>+				zero_len_trb =3D true;
>+			} else {
>+				zero_len_trb =3D false;
>+				field &=3D ~TRB_CHAIN;
>+				field |=3D TRB_IOC;
>+				more_trbs_coming =3D false;
>+				need_zero_pkt =3D false;
>+				preq->td.last_trb =3D ring->enqueue;
>+			}
> 		}
>
> 		/* Only set interrupt on short packet for OUT endpoints. */
>@@ -1962,7 +1965,7 @@ int cdnsp_queue_bulk_tx(struct cdnsp_device *pdev, s=
truct cdnsp_request *preq)
> 		length_field =3D TRB_LEN(trb_buff_len) | TRB_TD_SIZE(remainder) |
> 			TRB_INTR_TARGET(0);
>
>-		cdnsp_queue_trb(pdev, ring, more_trbs_coming | zero_len_trb,
>+		cdnsp_queue_trb(pdev, ring, more_trbs_coming,
> 				lower_32_bits(send_addr),
> 				upper_32_bits(send_addr),
> 				length_field,
>--
>2.17.1

