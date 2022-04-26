Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E45C50FEE0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350982AbiDZNZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350974AbiDZNZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:25:42 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89E2186BE5;
        Tue, 26 Apr 2022 06:22:26 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QCbsg0001664;
        Tue, 26 Apr 2022 13:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=TAyhFX3BlB3ZZ9QsCGlZzAgtLziJW5xYZC1lx9z/B1M=;
 b=HvtqFn8SxmsV/4ZnWgyK72XnWQaWuDgKn6ahmlMF78mUXfPRCeo6HDTUi4TvXi/BFbTB
 ykF+qaSBCd7bL4ICDokuXh75V3nFccrYQEEUfO3I1eAR1MM7P1MyYnhRPT1hcPkMc9+E
 KKsl2VZXilfI4RRKrD2K/uSdSjf8v/WQNzzsyYoFCjp66yJhl1LaROxf1mnVDBD+wsy6
 yXkIVh4cWUGiXKYfM7EiijsGMyNN4hi5S8YTi9AfzkyJiSTqS5FksN4pXu1P6uWInnDm
 0h/6szd5n5ZzQPYD/pilT4U3afR08RTJj4Ke+QyzzalkJtiLCTUvuz4H9k4UnyBPjrmu YQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fpf10hmvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 13:21:41 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id ABBBC13087;
        Tue, 26 Apr 2022 13:21:39 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 26 Apr 2022 01:21:39 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 26 Apr 2022 01:21:39 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 26 Apr 2022 01:21:39 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TW2aLavwFjg8H0I1JJiU7irKQi5tvkgFsueZXLtcM/AcxSi7D2C0Z+kmAwUVCZ/fO+G6Vp4ETJyxb5q+gAfVJzruUjD1A5Nlk07VMLJCGtgYdt4kurHebR2bntBU2X2KpVtWkAOrxa6xBzm+jIHWA9f5aMKyftSWUutgkZPkfn8BLuRFKhI8mKeCo7MzK/yUJ3JYJGZCjHYOczSM8eXo4bncJ+CBzZJs2EFtDA6Aw4coYMvwR5+Vb3l1R4V9TSpN27uLV9Q5HcQZU+Z1nOeuPj8MNHqf8xH7gG+hIn5DPh81AljdRPwaSWAqy7jteRh/JEh+8HvCzjeObyXjBZLHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAyhFX3BlB3ZZ9QsCGlZzAgtLziJW5xYZC1lx9z/B1M=;
 b=P1eGmPX6SLBsLaRH7Xn6jIz08r9wIgTFGeCNaLPecYC7jOfYTccN53zZ0+EDK2t5zlksCOPl5nmpuokr5ZIa5eGOfrCRtGLyq+/3msqODoumpxb53R+mkWJqiKNC7L6rSbY6LISR+boiyV7xHE/u8Q9SJC8iSSxo/uj1Wo1avJCBxsKh2ybo6e4PmS4fUTs2MsJp7Yl0vdtW22Owd+3SZ2iS95BU2qdwSVgbXWtdcYel8NAZu+GWo844S5dsywv/hdtXV/mfkooRMCRbTQC9vuRW/umydky0ZXEEZ0vpTyjhKQZP2CMKWuYgsevuHM9CEGSKgiyj2xwOJubTZhsgAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by SJ0PR84MB1649.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:430::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Tue, 26 Apr
 2022 13:21:38 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 13:21:37 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Rob Herring <robh@kernel.org>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "arnd@arndb.de" <arnd@arndb.de>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 06/11] dt-bindings: watchdog: Add HPE GXP Watchdog
 timer binding
Thread-Topic: [PATCH v5 06/11] dt-bindings: watchdog: Add HPE GXP Watchdog
 timer binding
Thread-Index: AQHYVbTOsVjE6kZL10OpjL+eSsDcLa0BNZcAgAD++BA=
Date:   Tue, 26 Apr 2022 13:21:37 +0000
Message-ID: <PH0PR84MB171845F606BC40AD653BEC8888FB9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
 <20220421192132.109954-7-nick.hawkins@hpe.com>
 <YmcbCgjD85lIRMSf@robh.at.kernel.org>
In-Reply-To: <YmcbCgjD85lIRMSf@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8c5e603-1deb-4a36-a7b9-08da2787b17e
x-ms-traffictypediagnostic: SJ0PR84MB1649:EE_
x-microsoft-antispam-prvs: <SJ0PR84MB164918990C10916CC1D4B5B088FB9@SJ0PR84MB1649.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a7XIx7ZUIpy5aupakgyUC28hj8/BTHc9Mu8ZdKYYWB/GK4gbszeo1JxboQ1QCtacV0JR+t2QaQfknMeDgI1FX/ufJrOPXEw33ao2HASfilJWkol1goZBJQ7/LC5k1jQQtB8f6aH8ZV4bsdP68E2DQfhlshlICNSZn+qI4l0V3qlX3N9/+ajtD17v9nCJBy8t05BpOwE/oL691JMgl0++hKNX7Ta1iHiVNd/IR1DsxzFHiPdjEyC/cgMc4fqz02dxL2M8CpYVGHXlJMc4dm8/BA2OtYAo77qsk/ZQJxauGP+/QbL4uw4MY/GF+74leab3Zzrpy/5oln0FAv3J2oGGZg+73f7+ivaAzuQcDMKWrIEInMSmEYyO2VE7K9m1zv8uEouAFjlqduvEJzPRKCbwcnjUYBmmDbvJlF4UQrPMWifjFaLC2cfWFhtQ1YtJlPteCGkfKa+5+Q9/PutyeoXpSXfalGKXSUCH/MUsPvSqGL6NRRhevpB7Mo5KdrgaRZDDXdUopi2Vy+Ha8qOVC2R53cv8F0Yr/cHPGTYDbZE26cxtN/wawNkQc7IaUX+gUeXCY5/yFEb5iz32OdskoObX+GkpzmfMEMc/w3Pz0Jb0QVDETi3sTJQpe9IlQgdbvA3jWiB2BsuMInnKBaW+ojP86lDOSwxW9v/2rT5UpGFTTwnjiUMbuMzaMT1MclTDksfHS7Mz6NgwGDAKKsSYeL5njw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(83380400001)(66446008)(33656002)(508600001)(52536014)(8936002)(2906002)(76116006)(64756008)(82960400001)(316002)(5660300002)(66946007)(66476007)(186003)(71200400001)(4326008)(38070700005)(8676002)(55016003)(38100700002)(7416002)(4744005)(53546011)(7696005)(55236004)(9686003)(26005)(86362001)(6916009)(6506007)(54906003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GcyYnZz0tfDlsxamULv2JfCKl/DFR3I+TABdpXVCZ3kcODHHKJ2Feawnv7Ei?=
 =?us-ascii?Q?oUjUQeWvpvSnmBz/M0vnM+qlcI1eyUcuNkDCc3QmLOVJhwRN+/4+GdAj5p5W?=
 =?us-ascii?Q?sMHz/RAT+C6ionOf6stQ/V+IkiO8S7eCwQgR8NSv9VF1AyrJnbT1mBM7tmAG?=
 =?us-ascii?Q?8WjF9uRydI+aUdP1t9nPg50CfeHAD/iq7C94M63Pf7tJNHi+7BDMJATY23rE?=
 =?us-ascii?Q?XKqML/m4RUDGpFxrojShNjDE2NJbIhFUmao7zWsChBrTlA2R3Om+EV/vKeHi?=
 =?us-ascii?Q?svh7osT9tVo2tTHSIATJns9PG53rwi+7dT23UhxmK1L1P+BanqgRQpTHWEUo?=
 =?us-ascii?Q?IqOuhB6QoFSGDsk6jS5wAcYjNOshf1mT8I4YBJYJL7cO2DOZSVtpgwMZv/SZ?=
 =?us-ascii?Q?LJksRrH6LWk+23QyKYehBe1ZVT1Ak6mfXVRmWMNlEG0KgXf8+7oZo4t1zkk9?=
 =?us-ascii?Q?zYU6n0RvdM1w5lMPpl1I64vQYMHx/DBqvV9wuKsHLJBVJMMUbMWZxn5uNncv?=
 =?us-ascii?Q?ckKhzRYWbpoKhXhKz+5XN8wFWBQlTZebzLr7S6BEuOVbDCtj1TRBnrcR4XTd?=
 =?us-ascii?Q?kuVElMruZ9lq2lK+stwB5HYTgsyrzxq4Ub9BpBuoMR6uUdCQZgwxa4cMYytC?=
 =?us-ascii?Q?gxv1Esz8ZGmsvBoMoYViHqh4AiPjixwbpXyvtMLYSOyAwNebJbbj3uCFIKCb?=
 =?us-ascii?Q?V2giGiv5OUo6vStVxaxWhYKM5eXBHos2atJFEsnp8KBNd9GLt/yT9StkXSCc?=
 =?us-ascii?Q?Q7yW6vrly3ui7g7kZpIq6LKJvZpDV4URh85L++gV5TO0k9+IFwTK6Y2SDwxo?=
 =?us-ascii?Q?J4QW4yUrTMFYoq2boEHjvGfxqWcY4lXw37o9vuMSRRgOAzRV1GxnQKuncXuh?=
 =?us-ascii?Q?NzfIudXDcnHjHn3d13x3QHVxrJ/faCdKzZP9AzB9Z9XmexTg6eJUGkt/XgIt?=
 =?us-ascii?Q?QUn1grqTxo+98mlK5uBofVnvUdafDVRXd1VB1WQLqWpN9s6cusufL9yxIQlW?=
 =?us-ascii?Q?ZCOnmNDzWClA1H3A0lO6gnTR8uyiSjjqbloWvoZqy6OBm9WB7ud5MyOAgtN6?=
 =?us-ascii?Q?vq1wfFDYAK08WWn0gVMElAGB8TsbdFb+VBkZwuPF4ygm7sLnd7AcZrIX4Vh3?=
 =?us-ascii?Q?17rf8fjo+X8gz2RjsOJ2qp1sz+8Omu2BVdiT7D1fRbqpILH4sIfKf9zGu879?=
 =?us-ascii?Q?VBSSvTVTi8QF7grYIx4eCf4aTT1W5Eg9n7X2gsv036Ah8UZRMZJgR4Z4X/wd?=
 =?us-ascii?Q?+0FOwl5De0IpxKed5DkVzAX/wCjrmW98TIuqA5aEe0FBosMLUw8nu15P9YYx?=
 =?us-ascii?Q?PfGo+NX+il92oo/BAKDsenfmyxchnNdBqlAqIIBduTeRqABrQOjxxsoCwhtL?=
 =?us-ascii?Q?yftHSEB3YmbxexZ2nAMlT5D1hN9LNmUTWlKohymMHpm5ha3+7y58ku3qPRzZ?=
 =?us-ascii?Q?FHRwTECVq/TQJiKbnik+aLwzjSKAGb+gBQXkyyLVbhFROhBdsvBAbyZBh3ji?=
 =?us-ascii?Q?Lc3sgHs9F3oEOBYihLkMFJkGWu1MqqAhxmeLcbsPP7BEJ3exrvmw5GwkvU+F?=
 =?us-ascii?Q?ogK4sJrMQ7fyqVd9Xp9L5lYtu4gM2+pvjHxAM0ZpPY+C+hqz5jg3sZQMmPWP?=
 =?us-ascii?Q?2LG2czSn1Y8OvV8vwuT2D/+TurTR3/2ywx4JD0IG2Tmz+i4Pau42HNym/QCq?=
 =?us-ascii?Q?OxcLvXKDFYf8L7QwjDO7UMqCbGmSGLWkJPgxoPQ1RECHgr7CzrmJTt8luVTJ?=
 =?us-ascii?Q?uc9m7FNrpQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c5e603-1deb-4a36-a7b9-08da2787b17e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 13:21:37.8126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sE36gj6aV0k6ZXIgd1THNAuvusDgBY0qlh4rnWK8L9d5mMbyP+7H5PfCLDgSFwJ2A0twxe8VrzLCWm0TW7UWWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1649
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: s1dG7aHG6O9y_J4eGhMQCDk1pCeU25Tw
X-Proofpoint-ORIG-GUID: s1dG7aHG6O9y_J4eGhMQCDk1pCeU25Tw
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_02,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 mlxlogscore=991 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260084
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Rob Herring [mailto:robh@kernel.org]=20
Sent: Monday, April 25, 2022 5:05 PM
To: Hawkins, Nick <nick.hawkins@hpe.com>
Cc: Verdun, Jean-Marie <verdun@hpe.com>; joel@jms.id.au; arnd@arndb.de; ope=
nbmc@lists.ozlabs.org; Wim Van Sebroeck <wim@linux-watchdog.org>; Guenter R=
oeck <linux@roeck-us.net>; Krzysztof Kozlowski <krzysztof.kozlowski+dt@lina=
ro.org>; linux-watchdog@vger.kernel.org; devicetree@vger.kernel.org; linux-=
kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/11] dt-bindings: watchdog: Add HPE GXP Watchdog t=
imer binding

(...)

> How is this h/w controlled? I'm guessing it's part of the timer? If so, y=
ou don't need this node. A single node can implement multiple functions.

It is associated with the timer because of the shared register set. Based o=
n feedback from Krzysztof I need to create a child node for gxp-timer. I th=
erefore will remove this file and move gxp-wdt to the hpe,gxp-timer.yaml as=
 a child node.

Thank you for the feedback.

-Nick Hawkins
