Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7874AE3F7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387560AbiBHWZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386298AbiBHUDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 15:03:18 -0500
X-Greylist: delayed 539 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 12:03:17 PST
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15246C0613CB;
        Tue,  8 Feb 2022 12:03:17 -0800 (PST)
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C9BBF41F21;
        Tue,  8 Feb 2022 19:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1644350058; bh=PRdvDssp+i9XU61IJ+PD7HRXwwYDFl1Qr/Jrj6VQtF8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Ynvj9O6uLc5SsgtCWd/JHS9dL32jkkrQl0ynuqpqP5XsXhmyqjL9AS126hcT1pO31
         Pg0bw3LQxLAU1UGuHPM+m99b1WL6eN3QK7vH2WUtA/CnQ9WaKb/IJj7zgeF73Cqddf
         yn+QiAvuTkXQ+2CKcrk92VacK6qwZ0qy0aznnlqhBbxnM7KJPGzWeb1cbft9gR72us
         ZUIVPJrLvyxhy4MBr6w5r/uhnO2uNnKHtYCHIfsM2JZEqFOz3g0zSWgrCQzDc7v+7Q
         Yr/e94NlqguMOLgbMTF7Li9EE3nBVE33rtTdE5BY2s6FIGgpbkL/O6EQjQ+MnQLlZk
         A6KpV20UO71RA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 23810A005C;
        Tue,  8 Feb 2022 19:54:17 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2040.outbound.protection.outlook.com [104.47.74.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 51B9180362;
        Tue,  8 Feb 2022 19:54:16 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="nW50v8aW";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxrVLia9U6W9RURR3OEisQBTmKqLwomezMgxxfPdaLgy3rOINWthdaA+Uh3uLxxqYUwmDBe1MwNDLcas4aR3ggzPRIfPcxMCDfAXcAYdhF6XMZh9GgGYf+JC3oo1Yo5Pw760i6qMjAROakR2NBZB3a4s0AFjdI7Ost8ctMlHI3ZSCAKAGs6Vw6Hz/Pr9Lt1laUxpZcz4aqyAlnquTUjEsGVrEhG2Qi5x7A2kx1HpNo6GOGZRQ04fkj6GmmP1gVHgQWxqVMqMGNIUhBHO68n3YHJxcrP/8+7hKIgvr/MADITH1C5tMHgnBofab78PJ0AMjNIKdjq9DYKPmottDmDqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRdvDssp+i9XU61IJ+PD7HRXwwYDFl1Qr/Jrj6VQtF8=;
 b=HaebJBU7d/BvXGC6GVWOCMQjgi6mIhz7bJMe8nmWKyIa7TAAjyl8wb9JkwHUUw8TDFWIMmtfj5ffHP4DfPJR+NugGHcde3LKsuFsoAnxMLeI4jouqlsM+qDtkzs/hldX+px9hhGu045n8svSw29xjGtMx3nWD9cRAyh7TCqvZE7x4RkiLcmJ/hqOzmbimBOW5jNDi0ZPrOdEqroSpeGFXdRGD1JIBHCE86CoPFqwQun/jey447MsiPnKyRkfaG+PUpRe0pp7EA0H/KFR/J5P5/OmzDJ53YUFoKQmlYpNLK/+Nh8BQJ1gusH8id6KgkLgf94pkTcs/BhEoxTDrfkq3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRdvDssp+i9XU61IJ+PD7HRXwwYDFl1Qr/Jrj6VQtF8=;
 b=nW50v8aWzktagIIUO5oLnIGyUWPhFEKontGudrpfiP2DZ4tZHXSFboQAlQ5KE8Pf4GOEYqBPp9w/Nx4I1nSe4rW1yLGfPQIRaykyXG94QtbrQpM8/UrI3xkfr8OcCIBMb1s6xJ1FYuYV8l7Zsda0s9fCrLuMWTc1xxdPgO3UVEk=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN2PR12MB3119.namprd12.prod.outlook.com (2603:10b6:208:ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 8 Feb
 2022 19:54:13 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 19:54:13 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Don't switch OTG -> peripheral if extcon is
 present
Thread-Topic: [PATCH] usb: dwc3: Don't switch OTG -> peripheral if extcon is
 present
Thread-Index: AQHYGvtR9SgA9sLUAkm90nPqyTgJ/qyKFVIA
Date:   Tue, 8 Feb 2022 19:54:13 +0000
Message-ID: <50f25a22-09f4-0f9f-a6c4-4b8e7e238b13@synopsys.com>
References: <20220206014532.372109-1-andrew.smirnov@gmail.com>
In-Reply-To: <20220206014532.372109-1-andrew.smirnov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bde6d3b-8460-4f89-9e9f-08d9eb3cc802
x-ms-traffictypediagnostic: MN2PR12MB3119:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3119F83C38A00AF28AAEF950AA2D9@MN2PR12MB3119.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PjG3EYnuorRhOpjw0lFdkeaSMo53HUZNit8pJ+E0qD4gcKcHvIMokThPseynLXWIZwRlTdsdyYHVjyhRkjNQ6mYrhEXyv8VHjwy47k1JBC66YYEjZQh7RzYsYd1rAElKZfrwXIZcNekP/WDslQ3VkdZjXGtl8GxSkKHMGJrvjDPctR3Dg4iw0ZbUgH2iFx2w7WmGFEU6Ih92dc2w5CUwO8x4cWgErDKNZffHiHOdsihcK7uTjlBv75Q5nG97VvU5s+soo2xy/6TTE/3z8idrApfIEF7h/Gfucj+gDTvYNB8m/zpo6eQ8haJf1n8JCjvv8C4CWqYs+FqzHGDVHi0iWLOQBMaXDOnfBSjA6xn4yEjjISbp+gH246mZ0QO4fcuiW97fCaB1WR/R+p1ZMk+oXjg1gLyHCZlkZyrKe2yQJonnSxzU6REgiadwkR4l8V2T8vTZ0I6VPlDlcOyBS7oJZV6hoBtdji/yjmex5+SBNJFRY87XNyivNzwkqMnCPQdxppXf+rwXN3vBt1NLKvdX1nNfvQY9AunQrvL9tRiTCex4S81prARsfW+XwKzev/RiLWBUgQ14U2G4hT5Yjb92xDnGS8DZIyyibHd544a6k2eNqmVJU+F2AiioqjOABJoY8OBWN8HjnIrsEYF22xuS8SSFZqtXmGLr72PEoWWmWmido6UVcqML8kMJzIQkzmPS0uRmXmiXLjh7Vdek2PBbWGWODd141BIePgSG7KmmViO2TT2bh7nLVcSbcfyoA5XjEuTP6R9Js2FO9Pg9GUE7pGLaKJyRBOIg4b3h4O5sT6uNJexy+tNnJobzuTsAtZwlQm6U/JC5+V7tUmsLB7T1c8niXhEPB6TmL1AUdnMZH3Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(36756003)(2616005)(186003)(26005)(122000001)(966005)(5660300002)(38070700005)(38100700002)(83380400001)(71200400001)(31686004)(54906003)(6512007)(316002)(6506007)(6486002)(76116006)(64756008)(66476007)(8676002)(8936002)(66556008)(4326008)(66946007)(508600001)(86362001)(110136005)(66446008)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnA0bDlTMnhHMHd2MjR5SFZzNTJsbmlpa3VEZWFpOGYxb0VDL291cncrV2FD?=
 =?utf-8?B?OFRTWWwvNFFvL0VyOUhBSGR3ejdIejQvYnpmR2dFUVFsWVZSaDJNTTJwWlZR?=
 =?utf-8?B?K09ka3EwSFJDQ0lrazFvb0w1d1RnVzl3b1VyNE5HYVhFZDdjN2NSc3Rnc3hT?=
 =?utf-8?B?RlVqWUFWUTdvSXFoOWZqTkh3bUNNUHJLZVhLbWhaUzF0MzdzVVQyZEJaVWtQ?=
 =?utf-8?B?c25zd3ErcFJBVHdNMzRPNXBDQ2NKVksvNWRjQStqTzV6NUV1ZkhCYkZmM3dE?=
 =?utf-8?B?a21VQXhUUk9hdTg2Z2J6cENLelhFMUlpdzFFVG5nWE50SHhqSmk0RWp4WjZO?=
 =?utf-8?B?UFcwYzBKNHo3Tk9haUoySDNYMmc0cno5MUdnZGpERlFCNmxZV2s3VnpIZHRB?=
 =?utf-8?B?TkROZGNiYjEwZms1YS9uM28vMVNZelNreFBSaGtEL3VoRHFNK3RhZktmT0V0?=
 =?utf-8?B?YjZ6d1VScm8xcTdoZFgybkJGUXVJMWRyc09oUkhibWZCWm9oa0ZQU1BZbXBW?=
 =?utf-8?B?NWVNNklqNGlCWk95dytjVkNRcnlzOVlCRXdmU3J3MElLclp3L0VqT1RPN3hQ?=
 =?utf-8?B?ZkdvbjhNaG4zYytTZjVJM3dZUmV5Z09rOTZmQkFEcVFNdHFUYzFRMkthK010?=
 =?utf-8?B?NVdPKytMN1grU2lYZENkYy8rQ2ZYUmVmRlUrTUd5RmZveEtIRzhkenlpUEFx?=
 =?utf-8?B?d21RcWVtK0pNR2NtWHorRU1wNnRjRTZjZDRndzk5d3ZsdE5rM3dMZVF4eGty?=
 =?utf-8?B?alZLTXVJZTBUVDFuRWt2Qm5oUDJ5bm1SZXdwU3hqcndGajB2b3YvR25ta28y?=
 =?utf-8?B?U0pBUCs3YW4xZWdqVkpPckI0emlURkd0MEZkWklNc3ZiQW02OVhzTTRNYTBB?=
 =?utf-8?B?RjRDaXVsNGoxZTQ5dkRrREtBYkI0ZmpuQjBpVEFPZmFCK0FKZ01IQ2tVZWZZ?=
 =?utf-8?B?U0NMR0laVlRkTERaSzZFMUNEcnIxTWUzbVdxTzJHVG1BZ09XVHNIVXR6dVc0?=
 =?utf-8?B?NElGSjhCOGJodXVJWFNjajFUcktwUW9nMHNrUTdKNGdaaTljeFgvS0dDZ09K?=
 =?utf-8?B?UFhIbjR1cUlmRTNQKzNHWXpRUHRDRzZEVHM5N1ZGOTN2T3ZqdkVmZm9XMG5k?=
 =?utf-8?B?Z3MxZHl4ZnpiRWp1WkRWSjZ0RGtkTVlWdzR3UWN4emljL25pdUVNR2VmNitJ?=
 =?utf-8?B?U29yT0pSV1AwZFNXVVRMQ0wvSUJiZ3VzeEp1WHcyMGVsTlR4UnRVZkE3T1lF?=
 =?utf-8?B?NGpOY0pKSUpDOXJnOFRiRTRwUGVyQ2VhVithZzdEN2l2azREQ0pnOW5hZ29E?=
 =?utf-8?B?dU0xdHdKZjVmYVFCcFVXNHZaZ1kyMzRyYXU1b2NNeDVYSjFadDdlVEx5eGk2?=
 =?utf-8?B?L0NzS0ZBZmIwZlhDYzB6RjhtOElVMEVtdDRvczlaTkU0SDhNVTVsdzZkSWNG?=
 =?utf-8?B?UHF5Y0FFQTZwTENQVDFTbytLaG1xVE9ldHhobCtsWjdYK3I2VUdpVjFxbVlr?=
 =?utf-8?B?RjlVYnRXTTFOL1pXRHFpdWNuL3ltMFhqc2FjcXE5TzZGUkJuWWhHYWV5cEhh?=
 =?utf-8?B?K24yMlF5OG82OXdtZkZEcWpNN2JnVnBmMzBJMmxFWXZGTkhWWkZLSVpUNHZX?=
 =?utf-8?B?Z2pja0NpU0tYTVJOSHM2dmVUUDY1WVZ6M2QvNXF6OUdRV09VKy96WUVsL0Jz?=
 =?utf-8?B?NHFmL0s1VVg0eWlhYTFBWklnSGF4NWt2N3EvWGRDNVc4OW1TSEFLSHc2WWhM?=
 =?utf-8?B?cldaNlNyZGRCdU1ZTlM1UldmdlhqaHgzQUxhUW04em5CODNtbUVzU2NyaWpa?=
 =?utf-8?B?SnNCZ3lmczBwRFFua0wzWFFwdU5yTTR4aW04Um5DTUN4dlp4U29TVkJ2R2V4?=
 =?utf-8?B?TVg1ZzJPRVRSSzFkbVpGa2VQODQ0MWV6VG8wN2d6ZzZ3SEJhTitQR0J3UkdQ?=
 =?utf-8?B?c1I0UXRnYmJ2cHNnNUljbFBacG9NY2puUlJ1TjZsM3A1cGpqbjJRY1V1U3Iv?=
 =?utf-8?B?dXpsN3pTVEtmTGRPMWVJNTJubDc0enVsQXJGZDVDTHVPSXZxWFRaQ3F6MXdO?=
 =?utf-8?B?R080ZkNQM0gyRVBJK2pnRDNZWlhUNEVxSE5WTGtVWHVQTGU3RTZsclJQbzNY?=
 =?utf-8?B?TkVhUUxtbFlVTU1NajV3ZDNtV1hQOVdDNUswUG1VNEZ0OVBzM1oyY0JDR0VM?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA4C431584BE0349910762FE656BCEF7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bde6d3b-8460-4f89-9e9f-08d9eb3cc802
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 19:54:13.5190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9rdsYA+UpIFbIfY9h/BB9+J9B3YMsWFD4oHh/rBIxYXvuqBCTVtkx5Dw5QXrmoyoPZ9JZ2scbEyBXR7iGNrC0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW5kcmV5IFNtaXJub3Ygd3JvdGU6DQo+IEl0IGlzIG5lY2Vzc2FyeSB0aGF0Og0KPiANCj4gICAg
Uk9MRV9TV0lUQ0ggJiYgZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkd2MtPmRldiwgInVzYi1y
b2xlLXN3aXRjaCIpDQo+IA0KPiBpcyB0cnVlIGluIG9yZGVyIGZvciBkd2MzX2dldF9kcl9tb2Rl
KCkgdG8gX25vdF8gZm9yY2UgdXMgZnJvbSBPVEcgdG8NCj4gUEVSSVBIRVJBTCBtb2RlIGhlcmU6
DQo+IA0KPiAgICBpZiAobW9kZSA9PSBVU0JfRFJfTU9ERV9PVEcgJiYNCj4gICAgICAgICghSVNf
RU5BQkxFRChDT05GSUdfVVNCX1JPTEVfU1dJVENIKSB8fA0KPiAgICAgICAgICFkZXZpY2VfcHJv
cGVydHlfcmVhZF9ib29sKGR3Yy0+ZGV2LCAidXNiLXJvbGUtc3dpdGNoIikpICYmDQo+IAkhRFdD
M19WRVJfSVNfUFJJT1IoRFdDMywgMzMwQSkpDQo+IAltb2RlID0gVVNCX0RSX01PREVfUEVSSVBI
RVJBTDsNCj4gDQo+IGFuZCBkd2MzX2RyZF9pbml0KCkgdG8gYmUgY2FsbGVkIGxhdGVyIGluIGR3
YzNfY29yZV9pbml0X21vZGUoKS4gVG8NCj4gYXZvaWQgYWx3YXlzIGlnbm9yaW5nIGV4dGNvbiBk
ZXZpY2UgcmV0dXJuZWQgYnkgZHdjM19nZXRfZXh0Y29uKCkNCj4gbW9kaWZ5IHRoZSBhYm92ZSBj
aGVjayB0byBhbHNvIGFjY291bnQgZm9yIGR3Yy0+ZWRldi4NCj4gDQoNCkkgdGhpbmsgdGhlIGNv
bW1pdCBtZXNzYWdlIGlzIGEgYml0IGRpZmZpY3VsdCB0byBmb2xsb3cuIENhbiB3ZSByZXBocmFz
ZQ0KaXQgdG8gc29tZXRoaW5nIGxpa2UgdGhpczoNCg0KSWYgdGhlIGV4dGNvbiBkZXZpY2UgZXhp
c3RzLCBnZXQgdGhlIG1vZGUgZnJvbSB0aGUgZXh0Y29uIGRldmljZS4gSWYgdGhlDQpjb250cm9s
bGVyIGlzIERSRCBhbmQgdGhlIGRyaXZlciBpcyB1bmFibGUgdG8gZGV0ZXJtaW5lIHRoZSBtb2Rl
LCBvbmx5DQp0aGVuIGRlZmF1bHQgdGhlIGRyX21vZGUgdG8gVVNCX0RSX01PREVfUEVSSVBIRVJB
TC4NCg0KDQo+IENjOiBGZWxpcGUgQmFsYmkgPGJhbGJpQGtlcm5lbC5vcmc+DQo+IENjOiBUaGlu
aCBOZ3V5ZW4gPHRoaW5obkBzeW5vcHN5cy5jb20+DQo+IENjOiBsaW51eC11c2JAdmdlci5rZXJu
ZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYt
Ynk6IEFuZHJleSBTbWlybm92IDxhbmRyZXcuc21pcm5vdkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAN
Cj4gUHJldmlvdXMgZGlzY3Vzc2lvbjoNCj4gDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMv
X19odHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC11c2IvMjAyMjAxMzExOTIxMDIuNDExNTQ3
My0xLWFuZHJldy5zbWlybm92QGdtYWlsLmNvbS9fXzshIUE0RjJSOUdfcGchT2xYZWx2My1xZFVD
aGJmb1Q5LVF0dHY0UEg4RERybzFkU3pJajZ4RU43eDNWa3Y4amVoOHVudk80UnZvbFVBJCANCj4g
DQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDU1ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2RyZC5jICB8IDUwIC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgNTQg
aW5zZXJ0aW9ucygrKSwgNTEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBpbmRleCBmMjQ0
OGQwYTlkMzkuLjBhZTE1MmU0N2EwMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTIzLDYgKzIzLDcg
QEANCj4gICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2RtYS1t
YXBwaW5nLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9v
Zl9ncmFwaC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4NCj4gICNpbmNsdWRlIDxsaW51
eC9waW5jdHJsL2NvbnN1bWVyLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4gQEAg
LTg0LDcgKzg1LDcgQEAgc3RhdGljIGludCBkd2MzX2dldF9kcl9tb2RlKHN0cnVjdCBkd2MzICpk
d2MpDQo+ICAJCSAqIG1vZGUuIElmIHRoZSBjb250cm9sbGVyIHN1cHBvcnRzIERSRCBidXQgdGhl
IGRyX21vZGUgaXMgbm90DQo+ICAJCSAqIHNwZWNpZmllZCBvciBzZXQgdG8gT1RHLCB0aGVuIHNl
dCB0aGUgbW9kZSB0byBwZXJpcGhlcmFsLg0KPiAgCQkgKi8NCj4gLQkJaWYgKG1vZGUgPT0gVVNC
X0RSX01PREVfT1RHICYmDQo+ICsJCWlmIChtb2RlID09IFVTQl9EUl9NT0RFX09URyAmJiAhZHdj
LT5lZGV2ICYmDQo+ICAJCSAgICAoIUlTX0VOQUJMRUQoQ09ORklHX1VTQl9ST0xFX1NXSVRDSCkg
fHwNCj4gIAkJICAgICAhZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkd2MtPmRldiwgInVzYi1y
b2xlLXN3aXRjaCIpKSAmJg0KPiAgCQkgICAgIURXQzNfVkVSX0lTX1BSSU9SKERXQzMsIDMzMEEp
KQ0KPiBAQCAtMTQ2Miw2ICsxNDYzLDUxIEBAIHN0YXRpYyB2b2lkIGR3YzNfY2hlY2tfcGFyYW1z
KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJfQ0KPiAgfQ0KPiANCj4gK3N0YXRpYyBzdHJ1Y3QgZXh0
Y29uX2RldiAqZHdjM19nZXRfZXh0Y29uKHN0cnVjdCBkd2MzICpkd2MpDQo+ICt7DQo+ICsJc3Ry
dWN0IGRldmljZSAqZGV2ID0gZHdjLT5kZXY7DQo+ICsJc3RydWN0IGRldmljZV9ub2RlICpucF9w
aHk7DQo+ICsJc3RydWN0IGV4dGNvbl9kZXYgKmVkZXYgPSBOVUxMOw0KPiArCWNvbnN0IGNoYXIg
Km5hbWU7DQo+ICsNCj4gKwlpZiAoZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYsICJleHRj
b24iKSkNCj4gKwkJcmV0dXJuIGV4dGNvbl9nZXRfZWRldl9ieV9waGFuZGxlKGRldiwgMCk7DQo+
ICsNCj4gKwkvKg0KPiArCSAqIERldmljZSB0cmVlIHBsYXRmb3JtcyBzaG91bGQgZ2V0IGV4dGNv
biB2aWEgcGhhbmRsZS4NCj4gKwkgKiBPbiBBQ1BJIHBsYXRmb3Jtcywgd2UgZ2V0IHRoZSBuYW1l
IGZyb20gYSBkZXZpY2UgcHJvcGVydHkuDQo+ICsJICogVGhpcyBkZXZpY2UgcHJvcGVydHkgaXMg
Zm9yIGtlcm5lbCBpbnRlcm5hbCB1c2Ugb25seSBhbmQNCj4gKwkgKiBpcyBleHBlY3RlZCB0byBi
ZSBzZXQgYnkgdGhlIGdsdWUgY29kZS4NCj4gKwkgKi8NCj4gKwlpZiAoZGV2aWNlX3Byb3BlcnR5
X3JlYWRfc3RyaW5nKGRldiwgImxpbnV4LGV4dGNvbi1uYW1lIiwgJm5hbWUpID09IDApIHsNCj4g
KwkJZWRldiA9IGV4dGNvbl9nZXRfZXh0Y29uX2RldihuYW1lKTsNCj4gKwkJaWYgKCFlZGV2KQ0K
PiArCQkJcmV0dXJuIEVSUl9QVFIoLUVQUk9CRV9ERUZFUik7DQo+ICsNCj4gKwkJcmV0dXJuIGVk
ZXY7DQo+ICsJfQ0KPiArDQo+ICsJLyoNCj4gKwkgKiBUcnkgdG8gZ2V0IGFuIGV4dGNvbiBkZXZp
Y2UgZnJvbSB0aGUgVVNCIFBIWSBjb250cm9sbGVyJ3MgInBvcnQiDQo+ICsJICogbm9kZS4gQ2hl
Y2sgaWYgaXQgaGFzIHRoZSAicG9ydCIgbm9kZSBmaXJzdCwgdG8gYXZvaWQgcHJpbnRpbmcgdGhl
DQo+ICsJICogZXJyb3IgbWVzc2FnZSBmcm9tIHVuZGVybHlpbmcgY29kZSwgYXMgaXQncyBhIHZh
bGlkIGNhc2U6IGV4dGNvbg0KPiArCSAqIGRldmljZSAoYW5kICJwb3J0IiBub2RlKSBtYXkgYmUg
bWlzc2luZyBpbiBjYXNlIG9mICJ1c2Itcm9sZS1zd2l0Y2giDQo+ICsJICogb3IgT1RHIG1vZGUu
DQo+ICsJICovDQo+ICsJbnBfcGh5ID0gb2ZfcGFyc2VfcGhhbmRsZShkZXYtPm9mX25vZGUsICJw
aHlzIiwgMCk7DQo+ICsJaWYgKG9mX2dyYXBoX2lzX3ByZXNlbnQobnBfcGh5KSkgew0KPiArCQlz
dHJ1Y3QgZGV2aWNlX25vZGUgKm5wX2Nvbm47DQo+ICsNCj4gKwkJbnBfY29ubiA9IG9mX2dyYXBo
X2dldF9yZW1vdGVfbm9kZShucF9waHksIC0xLCAtMSk7DQo+ICsJCWlmIChucF9jb25uKQ0KPiAr
CQkJZWRldiA9IGV4dGNvbl9maW5kX2VkZXZfYnlfbm9kZShucF9jb25uKTsNCj4gKwkJb2Zfbm9k
ZV9wdXQobnBfY29ubik7DQo+ICsJfQ0KPiArCW9mX25vZGVfcHV0KG5wX3BoeSk7DQo+ICsNCj4g
KwlyZXR1cm4gZWRldjsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0IGRldmljZQkJKmRldiA9
ICZwZGV2LT5kZXY7DQo+IEBAIC0xNTYxLDYgKzE2MDcsMTMgQEAgc3RhdGljIGludCBkd2MzX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCWdvdG8gZXJyMjsNCj4gIAl9
DQo+IA0KPiArCWR3Yy0+ZWRldiA9IGR3YzNfZ2V0X2V4dGNvbihkd2MpOw0KPiArCWlmIChJU19F
UlIoZHdjLT5lZGV2KSkgew0KPiArCQlyZXQgPSBQVFJfRVJSKGR3Yy0+ZWRldik7DQo+ICsJCWRl
dl9lcnJfcHJvYmUoZHdjLT5kZXYsIHJldCwgImZhaWxlZCB0byBnZXQgZXh0Y29uIik7DQoNCmFk
ZCAiXG4iID8NCg0KPiArCQlnb3RvIGVycjM7DQo+ICsJfQ0KPiArDQo+ICAJcmV0ID0gZHdjM19n
ZXRfZHJfbW9kZShkd2MpOw0KPiAgCWlmIChyZXQpDQo+ICAJCWdvdG8gZXJyMzsNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHJkLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2RyZC5jDQo+
IGluZGV4IGUyYjY4YmI3NzBkMS4uOWE0MTRlZGM0MzlhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3VzYi9kd2MzL2RyZC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHJkLmMNCj4gQEAgLTgs
NyArOCw2IEBADQo+ICAgKi8NCj4gDQo+ICAjaW5jbHVkZSA8bGludXgvZXh0Y29uLmg+DQo+IC0j
aW5jbHVkZSA8bGludXgvb2ZfZ3JhcGguaD4NCj4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9k
ZXZpY2UuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9wcm9wZXJ0eS5oPg0KPiANCj4gQEAgLTQzOCw1
MSArNDM3LDYgQEAgc3RhdGljIGludCBkd2MzX2RyZF9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJf
YmxvY2sgKm5iLA0KPiAgCXJldHVybiBOT1RJRllfRE9ORTsNCj4gIH0NCj4gDQo+IC1zdGF0aWMg
c3RydWN0IGV4dGNvbl9kZXYgKmR3YzNfZ2V0X2V4dGNvbihzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAt
ew0KPiAtCXN0cnVjdCBkZXZpY2UgKmRldiA9IGR3Yy0+ZGV2Ow0KPiAtCXN0cnVjdCBkZXZpY2Vf
bm9kZSAqbnBfcGh5Ow0KPiAtCXN0cnVjdCBleHRjb25fZGV2ICplZGV2ID0gTlVMTDsNCj4gLQlj
b25zdCBjaGFyICpuYW1lOw0KPiAtDQo+IC0JaWYgKGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2wo
ZGV2LCAiZXh0Y29uIikpDQo+IC0JCXJldHVybiBleHRjb25fZ2V0X2VkZXZfYnlfcGhhbmRsZShk
ZXYsIDApOw0KPiAtDQo+IC0JLyoNCj4gLQkgKiBEZXZpY2UgdHJlZSBwbGF0Zm9ybXMgc2hvdWxk
IGdldCBleHRjb24gdmlhIHBoYW5kbGUuDQo+IC0JICogT24gQUNQSSBwbGF0Zm9ybXMsIHdlIGdl
dCB0aGUgbmFtZSBmcm9tIGEgZGV2aWNlIHByb3BlcnR5Lg0KPiAtCSAqIFRoaXMgZGV2aWNlIHBy
b3BlcnR5IGlzIGZvciBrZXJuZWwgaW50ZXJuYWwgdXNlIG9ubHkgYW5kDQo+IC0JICogaXMgZXhw
ZWN0ZWQgdG8gYmUgc2V0IGJ5IHRoZSBnbHVlIGNvZGUuDQo+IC0JICovDQo+IC0JaWYgKGRldmlj
ZV9wcm9wZXJ0eV9yZWFkX3N0cmluZyhkZXYsICJsaW51eCxleHRjb24tbmFtZSIsICZuYW1lKSA9
PSAwKSB7DQo+IC0JCWVkZXYgPSBleHRjb25fZ2V0X2V4dGNvbl9kZXYobmFtZSk7DQo+IC0JCWlm
ICghZWRldikNCj4gLQkJCXJldHVybiBFUlJfUFRSKC1FUFJPQkVfREVGRVIpOw0KPiAtDQo+IC0J
CXJldHVybiBlZGV2Ow0KPiAtCX0NCj4gLQ0KPiAtCS8qDQo+IC0JICogVHJ5IHRvIGdldCBhbiBl
eHRjb24gZGV2aWNlIGZyb20gdGhlIFVTQiBQSFkgY29udHJvbGxlcidzICJwb3J0Ig0KPiAtCSAq
IG5vZGUuIENoZWNrIGlmIGl0IGhhcyB0aGUgInBvcnQiIG5vZGUgZmlyc3QsIHRvIGF2b2lkIHBy
aW50aW5nIHRoZQ0KPiAtCSAqIGVycm9yIG1lc3NhZ2UgZnJvbSB1bmRlcmx5aW5nIGNvZGUsIGFz
IGl0J3MgYSB2YWxpZCBjYXNlOiBleHRjb24NCj4gLQkgKiBkZXZpY2UgKGFuZCAicG9ydCIgbm9k
ZSkgbWF5IGJlIG1pc3NpbmcgaW4gY2FzZSBvZiAidXNiLXJvbGUtc3dpdGNoIg0KPiAtCSAqIG9y
IE9URyBtb2RlLg0KPiAtCSAqLw0KPiAtCW5wX3BoeSA9IG9mX3BhcnNlX3BoYW5kbGUoZGV2LT5v
Zl9ub2RlLCAicGh5cyIsIDApOw0KPiAtCWlmIChvZl9ncmFwaF9pc19wcmVzZW50KG5wX3BoeSkp
IHsNCj4gLQkJc3RydWN0IGRldmljZV9ub2RlICpucF9jb25uOw0KPiAtDQo+IC0JCW5wX2Nvbm4g
PSBvZl9ncmFwaF9nZXRfcmVtb3RlX25vZGUobnBfcGh5LCAtMSwgLTEpOw0KPiAtCQlpZiAobnBf
Y29ubikNCj4gLQkJCWVkZXYgPSBleHRjb25fZmluZF9lZGV2X2J5X25vZGUobnBfY29ubik7DQo+
IC0JCW9mX25vZGVfcHV0KG5wX2Nvbm4pOw0KPiAtCX0NCj4gLQlvZl9ub2RlX3B1dChucF9waHkp
Ow0KPiAtDQo+IC0JcmV0dXJuIGVkZXY7DQo+IC19DQo+IC0NCj4gICNpZiBJU19FTkFCTEVEKENP
TkZJR19VU0JfUk9MRV9TV0lUQ0gpDQo+ICAjZGVmaW5lIFJPTEVfU1dJVENIIDENCj4gIHN0YXRp
YyBpbnQgZHdjM191c2Jfcm9sZV9zd2l0Y2hfc2V0KHN0cnVjdCB1c2Jfcm9sZV9zd2l0Y2ggKnN3
LA0KPiBAQCAtNTc1LDEwICs1MjksNiBAQCBpbnQgZHdjM19kcmRfaW5pdChzdHJ1Y3QgZHdjMyAq
ZHdjKQ0KPiAgew0KPiAgCWludCByZXQsIGlycTsNCj4gDQo+IC0JZHdjLT5lZGV2ID0gZHdjM19n
ZXRfZXh0Y29uKGR3Yyk7DQo+IC0JaWYgKElTX0VSUihkd2MtPmVkZXYpKQ0KPiAtCQlyZXR1cm4g
UFRSX0VSUihkd2MtPmVkZXYpOw0KPiAtDQo+ICAJaWYgKFJPTEVfU1dJVENIICYmDQo+ICAJICAg
IGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZHdjLT5kZXYsICJ1c2Itcm9sZS1zd2l0Y2giKSkg
ew0KPiAgCQlyZXQgPSBkd2MzX3NldHVwX3JvbGVfc3dpdGNoKGR3Yyk7DQo+IC0tDQo+IDIuMjUu
MQ0KDQpSZXZpZXdlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29t
Pg0KDQpUaGFua3MsDQpUaGluaA0K
