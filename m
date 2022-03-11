Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6052B4D6601
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344292AbiCKQXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349984AbiCKQX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:23:26 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1A11D17AC;
        Fri, 11 Mar 2022 08:22:23 -0800 (PST)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22BBWBe0021407;
        Fri, 11 Mar 2022 16:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=zcTRkIfFNqGlZ9bXyO5REkemb5B23iyFre1V/xycI18=;
 b=lfk4pz/0N2mzggkr08j6gm1vq6dAJBKwnQT866qoWg+wzSWsB4o4E/k5kFQ39ZoawWDH
 jnTqBz9rcoFGPezqbLm0rcjONDBJmzLLsfJ7Zcxl8oOhd0t1PdUdBUMPhK3oJAnMPjGJ
 QGU8lDfwzzZs+EktajX47rpkIQ25devesrPGqHfhyeL9dWfMylRPfQhYr9U+8UrhXkX0
 RjA7q4kxBXesUyl+/0sFs6oEpH0lcHlsclZjgbtnH65RW7b+ChyoYLOVrGwM5X80VIRM
 3bNV7Aw3Kb6Vj++bvsCUazh+NhLVVr2dw7+9U/m6DusvJlIaWHAYOcUoA2XDbIQKKtls zQ== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3er4n82vxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 16:22:15 +0000
Received: from G4W9120.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.210.21.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2353.austin.hpe.com (Postfix) with ESMTPS id C051A65;
        Fri, 11 Mar 2022 16:22:14 +0000 (UTC)
Received: from G4W9121.americas.hpqcorp.net (2002:10d2:1510::10d2:1510) by
 G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Fri, 11 Mar 2022 16:22:14 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.241.52.11) by
 G4W9121.americas.hpqcorp.net (16.210.21.16) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23 via Frontend Transport; Fri, 11 Mar 2022 16:22:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7sBO3YhfNyo6MDr90zsPzDRYLLkFAk+R7CpPnRfQuEkrWSYH6Ry8SjKRmDptEPkxLSDKa8OcD3uDIMhhN+ynXA2ZCrybsLI1K0PXO9V/KM/udRNYS9XcozGyxTS2MJ32SFcPD8Yqyfd1U9W3pvjIoou5Ga5CqAmjW0gcOxmaTRAS3uyn5GDGu3+GDWzH7IzuRMgY2Ttrqq1v75vcYEeMqAqMyfgL9FwXQ7+p3PNoMkHBQz0ZncXNe4rbm+VTMCs9VsVtkFy63mwswKZBcAf8y4BF3AbXzZztUMb1R2xB065Toz/nb04vP/acLNYhgRWC84u/aFTYTvMFZwdA9sSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jbt4PePvUDDogu/8tMq0BTvPnWxH7rDRA/MqWvBoe8Q=;
 b=E1n2/86HPHTzcMeG2/0s/NkqyCobwfHGXHQKg2t6KVU0YVPUMoMMYE946X+YP2U/LbwMITaKd86t4MiNp+xQ4C3VW9BuRCyV00TL4PIZsDlN8AIUEqVl36db/aMMRfS68oeY5kngk5Ecv/EizSaNDtNKqf+fwDHW/DskLsLjo1GhZLHKHnAotpKBq7pYE/rHDAw8839NSN6qFR93l8M/vPiL690n4WiB+Un+dyhZU8plwWnb369jY/LpTzCfCLpX6tvgplJPoEZskpfSBB+aXonm0C68o2tiZdvN68LRRo0V2V+e9SM2WVxiwL5GxKZjoBsuMyth7/uF40lKZppGUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by DM4PR84MB1903.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 11 Mar
 2022 16:22:13 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e40c:dff1:1884:c484]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e40c:dff1:1884:c484%7]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 16:22:12 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Rob Herring <robh@kernel.org>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 05/10] dt-bindings: timer: Add HPE GXP Timer Binding
Thread-Topic: [PATCH v3 05/10] dt-bindings: timer: Add HPE GXP Timer Binding
Thread-Index: AQHYNLglDv1T67za1UCP4V4UhjYMv6y6UxyAgAAIefA=
Date:   Fri, 11 Mar 2022 16:22:12 +0000
Message-ID: <PH0PR84MB1718CAA1172CE891AA4E361C880C9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-5-nick.hawkins@hpe.com>
 <YittU9MfIFye9e2p@robh.at.kernel.org>
In-Reply-To: <YittU9MfIFye9e2p@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 458e5127-dd9e-427e-93d2-08da037b4cbc
x-ms-traffictypediagnostic: DM4PR84MB1903:EE_
x-microsoft-antispam-prvs: <DM4PR84MB190374D57DD364B4FA5A59E2880C9@DM4PR84MB1903.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ba/TTvcEAuhrP+i4E1w6g16DYIU25MLY4/xUzwBzAGlHh4ieMwkw0unJcX6iPxPEEOsS3foDHMV9tEXAFUUYXpdAqXf4TkubIuU4l93ETjl3ESSohryaqxUIg589J0ebcLM+hKou4xqBiu/Pm0KAgeCqoOKBDsjgCaPQvH9O9yjNXVoP6dLWEI7rTWNK/jG1MJcYs1bObRJr6wBV2zX6ZS2XsyPGD8HmS+79WjOtGYjYXwPCx/w02IrIgAmyAK5vwvo3lwu5b77KFyaGOproFjOsPY0zp/C/33iiq0/UMkKS3m+DosZ68RyRK7RRF9TVzNbEZSyrfiPxyEMPa2WDkwDGXCUp16tudSD2eYunBqhS3jtS9HtCXwoPM/MWHl5TuXpx5BwP+EkZzWM1q+X9b1VbY4Fzy7IkSInYu1rTTRnsBHxu20CJ+T+l/PeqS9f5XRD3Cs3Tnd1g/zKdumEDEGN0EdCd6oSTaS4o4+HSJcFUAYURY7GntvskZGlHQ2ipbgWhE70jgBx/8fVcbEKzozHNMRf0Cohk9qKTU6Z91Wc8EgsyzliZbBOKOdZiTXMsFD3Px04TKCgxHTtlLYirKQMXY5IgtyfM53C3qebvrNhXvz8sTzwUuKEG1vE16smzIr114oaSGQT6NL6Xvih6NW1gPhiaW+3D1NbiFRxBp2Zufva/V3tXYxfXI7gOdpAEC+reLxBNbMsLhc/UnJvgaKi/E5t55HzuxZOYTrGTwviLIcCtpJtqft84/3hCU+zRaRIa2VYOnZoxbiS6ASn14KZZ/jk3gvCHIQ9lJGyput84PtUfS/hKmqqxppR9lyX2XgxI2CipdsJWRs4nvNFOlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(83380400001)(71200400001)(38070700005)(5660300002)(82960400001)(8936002)(55016003)(2906002)(316002)(66946007)(76116006)(8676002)(4326008)(66446008)(64756008)(122000001)(86362001)(6916009)(52536014)(66476007)(66556008)(54906003)(38100700002)(6506007)(508600001)(7696005)(9686003)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?29vjWugYgawSosrH7XgyVqEQ1TZZYEbByuPnljZuskikko9JeTBs/r5vw8go?=
 =?us-ascii?Q?b9AtEJWWwLGse/E1kZjPjjKu54ud8cXMefslxrSbpZNY6deHSKuJMmbtJ/c7?=
 =?us-ascii?Q?cSYIVuTrqtrCd4rqVhmzr6o/EeUYElAv2Plo1PkCmGLElmec6Qf4O0XRtC/2?=
 =?us-ascii?Q?vNgebxpe3sN3J0nOvCywAnSJFNm8d/5LiuYCqD4Bp5UXZeacmBbPtw4Ww+Ab?=
 =?us-ascii?Q?/6qaGpk2/4A0PxrN9TZ3zYCoPImYrYNMowyID2o338XkMIxU22RFWVV54yNJ?=
 =?us-ascii?Q?cToZiciFVZIj5eY3b6DLEUaavSYRMYE5yRwToZYBmWm12wDgefipFoKiqg4F?=
 =?us-ascii?Q?Agkomn2+Pn8/Ra7iilKXBSezP1TtIJIqhpInWT0GjjAOeHEVXUNf7qnDI/ub?=
 =?us-ascii?Q?O9zbOmtajo9/crnJy3OoEAAqNpERMKCMjb+5/m7rvY8Z2tab69Sel9baBSCQ?=
 =?us-ascii?Q?+KhElw3lysgLiJiz2ivOXFpfaeFCfC3WHt7vfj/FEAXWiYWnFMoY/82ZmlB0?=
 =?us-ascii?Q?wSe8p8BV5ugkDka8X+aOs7SwSUe7eROp+vwXEGpriGo7mjdC2eOt9hfCAqWq?=
 =?us-ascii?Q?PTVC48bioSoq1ZGD1ZyuQDtFJtH11mBRFedmlc9q2TnYnzJDwanWYidQlWLI?=
 =?us-ascii?Q?cBxfOv9gBcC/bgyOw1e1urL01GfVvBn5jCJP5nzkSRkzhGFBxryR6vhA/ovf?=
 =?us-ascii?Q?l9/dTANvKCAYAYWhTsZwT420GCQK64VdfEY4wYa7XrYq+1EUsCtg3oMJ2uOF?=
 =?us-ascii?Q?mhHSNZ2xyHZpjNyYuRubsh88nRpL5GhPeuGl89SekpNCkDaKfniTTmsv7ILM?=
 =?us-ascii?Q?2x18i+EavBiYkV0tCUeDrThRLY6IPtVqoXrg7C2IwO4Pz1L6Dog6q56ShNP3?=
 =?us-ascii?Q?UNx58iS6tyifOz62Km4Kti9kvyAmGhPkdBOBq0xqL4HzltNOQiKsQtI58Tp+?=
 =?us-ascii?Q?RElskWOO1lzLwh6HrE5gAP+Ds62eLAe/k++l8xE2l633CPCAW6nsFfx13CX/?=
 =?us-ascii?Q?hWsFJwLf8dVIzeMToWTA3MQyOZdLn1W3sRBbskQ4ClltG+aU/WPEicSbu9qr?=
 =?us-ascii?Q?n2SOPDBIkGE+zHi9N9IKG7kPfj1rUcRYFlBWijcMkHBxAMND6fT3guPM09DJ?=
 =?us-ascii?Q?kOSaRsxX47JJWdlm4jwJ+NJjwJPJ6jsrNzLLexd9sEOFJNsWqkYR4bDRcxOI?=
 =?us-ascii?Q?jKMtC29ReCN7JbMYIhYcTXEmcqc77roUJLoVaeO4Xx7oKtpWbaM52qQXX+HZ?=
 =?us-ascii?Q?L3jBrTwFliKw61fKI4pv7w10ApTN3St5utYKI0h33hi63tYvl7NyuT1eT9iq?=
 =?us-ascii?Q?pox8HYWtXur0uBKkj2ruqVpoFKF6yxTlHnx8vNqcHjSbsMkfGHoFAhbbCzQW?=
 =?us-ascii?Q?7tEO5BQk9cFEV01hHjxrYJrriZlxphynZ1D0kvHmVzsNlMwv4Zy5+zYK0w00?=
 =?us-ascii?Q?CzWQ2M565tsumSgctK5+c0BGdH3YUD3JOe+pCyzNy8if9ruTS2+lHm1IgKZg?=
 =?us-ascii?Q?MpLr0vVxkHG6fo2i94gDSBepv3BblvIaiqQz7JWhCKkEJfqrLqcZ6G+KFhUl?=
 =?us-ascii?Q?4qdwj4D7fbpP4S5/XqjT3SCj6XmrhSxqXLGUZH0qP1lis8pBlKUCro+OFLrJ?=
 =?us-ascii?Q?h7I5WfH0GW8cLtwJgu3cUOg=3D?=
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 458e5127-dd9e-427e-93d2-08da037b4cbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 16:22:12.7757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vt2f6MANgn7PlUDZvQldZ6UNh4QSXRa8v5T/dIQS5IKxVMilBU/ppNQKA4gwin6tAF6lqcIC6cMwrv1dgtrtEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1903
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: EdwWUN5kERdbuZPXRhhP9n8eVPAPawfj
X-Proofpoint-GUID: EdwWUN5kERdbuZPXRhhP9n8eVPAPawfj
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-11_06,2022-03-11_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 clxscore=1011 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203110081
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 01:52:24PM -0600, nick.hawkins@hpe.com wrote:
>> From: Nick Hawkins <nick.hawkins@hpe.com>>
>>=20
>> Creating binding for gxp timer in device tree hpe,gxp-timer Although=20
>> there are multiple times on the SoC we are only enabling one at this=20
>> time.
>>=20
>> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>>
>>=20
>> ----
>>=20
>> v2:
>>  *Removed maintainer change from patch  *Verified there was no=20
>> compilation errors  *Added reference code in separate patch of=20
>> patchset
>> ---
>>  .../bindings/timer/hpe,gxp-timer.yaml         | 45 +++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>  create mode 100644=20
>> Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
>>=20
>> diff --git=20
>> a/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml=20
>> b/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
>> new file mode 100644
>> index 000000000000..1f4e345c5fb8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
>> +---
>> +$id:=20
>> +INVALID URI REMOVED
>> +xp-timer.yaml*__;Iw!!NpxR!yaItMPvjqEf3fKyp1xDQAzawRQDd8uDGTNKMlVPpn5Y
>> +56IUABMYbali7jonBl20K$
>> +$schema:=20
>> +INVALID URI REMOVED
>> +aml*__;Iw!!NpxR!yaItMPvjqEf3fKyp1xDQAzawRQDd8uDGTNKMlVPpn5Y56IUABMYba
>> +li7jmX565-G$
>> +
>> +title: HPE GXP TIMER
>> +
>> +maintainers:
>> +  - Nick Hawkins <nick.hawkins@hpe.com>>
>> +  - Jean-Marie Verdun <verdun@hpe.com>>
>> +
>> +properties:
>> +  compatible:
>> +    const: hpe,gxp-timer
>> +
>> +  reg:
>> +    items:
>> +      - description: T0CNT register
>> +      - description: T0CS register
>> +      - description: TIMELO register

> Is the spec public to know what T0CNT, T0CS, and TIMELO are?
No it is not, should I not mention the register descriptions at all?

>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clock-frequency:
>> +    description: The frequency of the clock that drives the counter, in=
 Hz.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clock-frequency
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    timer@10003000 {
>> +        compatible =3D "hpe,gxp-timer";
>> +        reg =3D <0xc0000080 0x1>>, <0xc0000094 0x01>>, <0xc0000088 0x08=
>>;

> Based on the driver these are 4 bytes, 1 byte, 4 bytes in size.

> Are there other registers in 0x80-0x95 range or do these offsets change i=
n other chips? If not, just 1 entry covering the whole thing would be bette=
r.
There are other registers in this range that cover different timers/clocks,=
 for the most part between chip generations the offsets remain the same unl=
ess there is an architectural issue.
Can you provide a quick example of what one entry would be?

>> +        interrupts =3D <0>>;
>> +        interrupt-parent =3D <&vic0>>;
>> +        clock-frequency =3D <400000000>>;
>> +    };
>> --
>> 2.17.1
>>=20
>>=20

Regards,

Nick Hawkins=20
