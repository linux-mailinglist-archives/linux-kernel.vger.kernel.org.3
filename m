Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A65949B377
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382755AbiAYMBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:01:13 -0500
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33]:57233 "EHLO
        esa16.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1390536AbiAYL6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:58:18 -0500
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 06:58:10 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1643111895; x=1674647895;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gXhp1J7hInasc1Kv8zXNqb2UDhOFhafJl8s8PcMNPS0=;
  b=WDIi5GZu5K/XOTgduls+shXtn39uiHWxC9wmQuL0KePMXBxC8Ax4f2gx
   yNYwvI+wGvsJhJfND+FLx0gaHu+x4cOzCkpZS107my/msFZEEiWfLQb5O
   vaVeTrKOJaa0R5DxlMOoUqUeFiVit4FlXmimis9OuZO3b6MOPrNgzDJ6h
   PZKWIv0Ap/W9q4Nd35hPMaidKteGf+7mKhSKD8BoOza9dphHFSeQwMZuU
   IKQGAf3nGrB8XrKIhrEzpjyhh6i1ILjIY0yYDCkTR9CtspywoQt/UBZA5
   BUtMoyYEze2G+PNJzzrXwKuNexFFzFcfMDE5xeOSJJ5zApOfmcYFi34vI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="48324030"
X-IronPort-AV: E=Sophos;i="5.88,314,1635174000"; 
   d="scan'208";a="48324030"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 20:50:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBCtL/asuGxQB+jNSROzVOhgjZT4rLBIkt69tzGHHN7A+Y5WYYvkAY9SAlv/UDSiR5K851Eu7/J9VQJBeWp4jZqzBZQo7wqc5agEXYRZlYwMEFp86x9fY4qJqlkkX1r5FoG6EBaFbP1VRPtzbcJd5ge/XIKXlG8N8IqwW9S/xZETAHxcx+MlXW4HlrA8YKXx5lSAQdgVRrWIgjoj07j5SWccs7l+QvMooa8cXoEZ+IDcKxcIw8lMRf2folGp4DwbQCnR1cYDr5gXEqpx4ndOVOtKT8X5wpNpU1Ksj5MjA+h0RJnUQaf5ADA2oWCW4kfkthy82v98/WqMw26lE3afwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HATWSZ6ejxXHsygWiVcxIwrJNl7FQH2l7MwYHEV1XK8=;
 b=VQlbS+qyQTeOKkPNq/NegbZEaVdop5+wFZeoFwS0cQvxE/zI0mC9v685awvZU+/tr47gaAe9wIQIX0F3D4f95cVTtFPbtfJ4EaN+7oAWWZf9ytheZsepTDa2f9Zeq5hux36XR4BVpB3cXJizuBIFfKxJQZ9yP+CW+dgiyBZjENmsfOLZZRazGwxBrP4Du8tlAkJpQnKmU+nJMBcAf720mOLOEKrJrOeL74yoa04bt4it5BHxBX7vqCXrJrY1RURieYcs54YiN85AOsvlsnUKX3uzZlaJg+Crsxs3xVK+EjOfmZZpt8ad1dFfeAGWsS/zVa4eoyClIeiQLNnPtKePeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HATWSZ6ejxXHsygWiVcxIwrJNl7FQH2l7MwYHEV1XK8=;
 b=lxg0dlMDL1PkoWTxkWvKDfMuhus9MrlH49pQPO5aE3WPK8B1oaGf5tZD075ck8XMO++VRoX0NpscfjE1TBnbMdoW+aydYY3W+Bz9Aafl8AMxbacnRXTsuvHrZkBJBmYy1pbUl5D7oCYEW9mCrHutDbB8Ic5IxTiRg8vWVa/TzyA=
Received: from TYAPR01MB6507.jpnprd01.prod.outlook.com (2603:1096:400:a2::7)
 by TY1PR01MB1482.jpnprd01.prod.outlook.com (2603:1096:403:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Tue, 25 Jan
 2022 11:50:35 +0000
Received: from TYAPR01MB6507.jpnprd01.prod.outlook.com
 ([fe80::a969:a685:8804:20e1]) by TYAPR01MB6507.jpnprd01.prod.outlook.com
 ([fe80::a969:a685:8804:20e1%5]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 11:50:35 +0000
From:   "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "halves@canonical.com" <halves@canonical.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Thread-Topic: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Thread-Index: AQHYBKVl3QVmCewphUe4SBvooFofu6xzugqq
Date:   Tue, 25 Jan 2022 11:50:35 +0000
Message-ID: <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
In-Reply-To: <20220108153451.195121-1-gpiccoli@igalia.com>
Accept-Language: en-US, ja-JP
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-01-25T11:50:34.747Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: 3d1ed568-0f39-3e64-d0df-62b9cb2ea1d6
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48e61267-39eb-4d08-bd06-08d9dff8e60f
x-ms-traffictypediagnostic: TY1PR01MB1482:EE_
x-microsoft-antispam-prvs: <TY1PR01MB1482B8DB1098137ED5F57836955F9@TY1PR01MB1482.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qaPSxjF8E5Hew8dvCmQM8+H62FcyREj3Z7KwJSd5NIjxXCggrnw3CCnKdKDgpiqffyPC8VMMJcAvvXRG7SXXf7Jn/5Ddx9z7604RHgUxC1juv8qCHYPOVBKXR18p2hfnJHhAyHaPnEkPzQJkxGUIKFYVXd3ARmKZASl5ZKg9FETzmfT1I9OV3v6LBmfDtUNnckUf1a+9pMlJqbaJBKwFIRfkvYklVu+jPcubpV8Cyaug7DgwMNJUA+lJocPHwYBQyf0ROh6ZDUkO969Y2Lz3hbCIr64g+zV0z60lE4xy5mbPb/46gH+v+057qtTSUJ7aAS1mNYyyaUHdOiCWdx2Jyx1IZmI546EL64Z5eHwMsecSSEha7MOpIzJEOoZUSVYfkA5D9zdpiSLp+a+y/gGAT+VNHD+xSY3a6s172MgDft8fx7xb3aRuCQSQ/sYSdsBZywGp3bOj8jdRRRS8jBECOPKQIsChNzzGWE7zg2H07SUrtBH0IWnUKloH2lO1XPHj7tc6RbT17bJHWoJHYvyysrCTjNmAtawFcwcGb0ymgYa8Y7nuz+ey8UK8lb01hhO2MsovqOS3/GMUi+1l018NzGGYFF4T8HT9q/4pB3wpUqNu6mSzNUrtSqlgpNjN22kO5pOnnwFBjJ49eQAg22Az8Kijhw/dXKyAAn+vr22oTCdxy6nGQy5mJ9X/etrKPWmptaAtbmcNEPHjPlzJE75y/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6507.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(6506007)(66946007)(64756008)(7416002)(66556008)(9686003)(38100700002)(52536014)(86362001)(8936002)(66446008)(55016003)(76116006)(110136005)(66476007)(54906003)(316002)(2906002)(26005)(107886003)(186003)(4326008)(122000001)(4744005)(82960400001)(508600001)(38070700005)(33656002)(71200400001)(7696005)(8676002)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?S3gvTXdzQ3VPWWZqMUpzNmxsazdaRkZrR2NTOThreGVVZS9rOThPZGZT?=
 =?iso-2022-jp?B?eUtWNGVaUk1POVFLK2NDeE15Mnp4K1BjNEV2ckhSWUJJVURZQ3kxTGFY?=
 =?iso-2022-jp?B?ZHFxVDRIS0l0VDVmSDRVZmxwSmovc201NFlMdTZidkpvZjl1WllObFNq?=
 =?iso-2022-jp?B?WFRRSnVFVjBBWGxlL0lTbVJuMUJNYlpUM0tScjI3UHBRd21FdXVJcDhm?=
 =?iso-2022-jp?B?ZHJyQkJKdjhBZ0tZVXlnaHdXZnVBWk54d2VIQk1WeTFhN3NKYzg0RkhP?=
 =?iso-2022-jp?B?dFdtdUx5UWZaYmNlTkY3alNBOEYzUmdKajQyYmNGVVJJcVBDdXppSFBv?=
 =?iso-2022-jp?B?dlVKVGZjWW1aR2I3WitaTU9IVTFZY0xqdHV2RUNpSHJuT0hTbTBWNVVJ?=
 =?iso-2022-jp?B?Z3htNit5QXAwdXYxOWo1Q2NuV3FjU0RDYW1wYnN4cFptQmdWWmFnUWVE?=
 =?iso-2022-jp?B?TjhRTG9aUHRJdVZPMERZSmZRb0txdEVmNmVqbDNlcW01eDk1cEFyR2RN?=
 =?iso-2022-jp?B?L0JkempsR21raGJJdmtuSTRnTDI2eUFENkVuMDA4YTUwdlR6d3ZneEpK?=
 =?iso-2022-jp?B?ZzBOL281ck5lbG56dk9wTjM4OTZDNzJrRWtLOFg1SXVnOGwwcS8rK0pW?=
 =?iso-2022-jp?B?Z25qZ1VoKzYxWGdOOU9mQUVlYU1jOFRNUVJMS20rWFBhOUhYci9Nc0hZ?=
 =?iso-2022-jp?B?S3RMRFh1ekFQMWRCMXp0MEMyTGZHbjRQOWJuZEZPTGJLTVVWdEdQWEFW?=
 =?iso-2022-jp?B?NmZXcjhucVBtQXNVd1htbm5FOVlhbFlrMjRLWFI3enhaTFo0QWNoWmpX?=
 =?iso-2022-jp?B?RHMwd0hkdSt0OWZjVENOMjAzdFBVNW5XcThpUTcyNUpZUFptcjdjTVo1?=
 =?iso-2022-jp?B?NnRxQUJJMG1lR0sySm1jR1NPejIxYUROeGoyNklJMERkQmZCcDNiMlVU?=
 =?iso-2022-jp?B?bXoxdmQ0OTBKTTVjd2w1ZXNqS0FsTy9PTGNRa2ZuSXJNZjVjMGhTdWJF?=
 =?iso-2022-jp?B?aWNTK3N2bXlkTGZpaWw4S25CV2E0ZlorbGdNdGRtbFNVYUMrdUhYbmxJ?=
 =?iso-2022-jp?B?RE4xMDRjdDZCMENDZzlXbmtRcGZnendySXVnQ3hPNXAxbCtqcXZkWWwy?=
 =?iso-2022-jp?B?UmF4Z0hwZDVRM3VnNFNqNmtoOFpNSGk4ekFUWm1TVis2SHZ1aGs0RTda?=
 =?iso-2022-jp?B?S0dMOGtqb1dpZmhPZmc5ODl3SDI5RWFueGpyWkpQN25yclRydnI3WXdn?=
 =?iso-2022-jp?B?SVMyc3ZhT3BWd2tzS2tYZ3J2N1pNRXFXS0ZkN1k0Wk1tLzVyRlFlUHpT?=
 =?iso-2022-jp?B?OXlkOEZSRlRadi9oQzJzckJSUkpCd1pqVVgzSHVUd1h5Qm9LQzN2cVZ5?=
 =?iso-2022-jp?B?ZENtcWNaSHMxdzFnMDl2QzdGWS9ndlpsTk9vVW4zd3V2YlBCd1NrWVBI?=
 =?iso-2022-jp?B?eXNsNHVlaC9DaEVKQXhGbHVhRmQ0bzZJOTBMQ3ZwRUpOdFBUb293YVFI?=
 =?iso-2022-jp?B?djRBS3Z1L2UvRmNYUUNYTXgzTEt5TmJhZ1A4blZWeUJ5REQzWWVSK3ZI?=
 =?iso-2022-jp?B?cXFMWlZ1UkJpM1V3K2lybzZtT0JRM1FjQ0lianJ6a1ZmSlg1L3NNWHpC?=
 =?iso-2022-jp?B?Q0R2T1R2alVoZ0wweEIxZG54VUFway9MZmU2N2FRa2U4bXZIWU1ZL2RV?=
 =?iso-2022-jp?B?RjdER0QyNFNVYXNtU3k1MldSeFlqQTlzYTlqKzdMNG5HVk44d1JrRHhV?=
 =?iso-2022-jp?B?Vzl3RGg2SDRCS1FOa2tiQnczNGFMRTRlVzVvd2lkUjRSUW13NVA5bXQ2?=
 =?iso-2022-jp?B?empVcVBNOVl0YlNNbkluVlJvSDNlK3FVREVoblBrbEJpQ3F0NnIxVkw0?=
 =?iso-2022-jp?B?Q3hQZU01akMySDhKM2lZcUdsVEwza0ZmamVQeHlWWnFSWEtkTjEydVRr?=
 =?iso-2022-jp?B?SzRBQWFBblNEWWVoWlpMd254OXp6SVJVVEJreGt3OUYxV1VxTmVmcEZv?=
 =?iso-2022-jp?B?MlEycUdIQWVOSTl4OTRGS0ZXSGp1cDNPckRPdzNvWXFLSmhoNTFvM2xN?=
 =?iso-2022-jp?B?RXlNaW8vWDc4VEttZTlwVnVpdmJzZjhJZFNJRytLUUlJUVh5TVFxbW9p?=
 =?iso-2022-jp?B?OWJpeTViL2NKZ3lkaXpTYVZqN2FhbTNIVEUzVlJqSmQ0M3piVWRseTM4?=
 =?iso-2022-jp?B?WURvNXhOdVM2YUpDMGNtQlNYKzk1N29uekNmZkNFRnM0Q2J6WXVwT1k3?=
 =?iso-2022-jp?B?MlZaUWJzSEF3ajcwNGRiTytvay9neWkxSTRJMGJ0VU5OUnM0OVpHTWk3?=
 =?iso-2022-jp?B?N0p6b2VRR0FBREZHSlFicE0vZTc5ZlBvcmRSNmF2VGZ3ZXVsWm5EZ1Ev?=
 =?iso-2022-jp?B?amtzeXJ2Z2R2b3Npenk2Q3QzTVplR0tWOExKTlp3L2E5RjBiSzRLQzh6?=
 =?iso-2022-jp?B?UHc1em1nPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6507.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e61267-39eb-4d08-bd06-08d9dff8e60f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 11:50:35.3373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+uXuEZzV3ltsSdCSbAnmGAbxYTfiSzXN8RY5xlJIuymEa63PT+GfACpuMsaQey/XRde2fQNE5pFg/mKI9HHQ/PdK1MB/OO/Lm91rIuF2IE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1482
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -146,6 +157,34 @@ void nmi_panic(struct pt_regs *regs, const char *msg=
)=0A=
>  }=0A=
>  EXPORT_SYMBOL(nmi_panic);=0A=
> =0A=
> +static int __init panic_notifier_filter_setup(char *buf)=0A=
> +{=0A=
> +       char *func;=0A=
> +       unsigned long addr;=0A=
> +=0A=
> +       while ((func =3D strsep(&buf, ","))) {=0A=
> +               addr =3D kallsyms_lookup_name(func);=0A=
> +               if (!addr) {=0A=
> +                       pr_warn("panic_notifier_filter: invalid symbol %s=
\n", func);=0A=
> +                       continue;=0A=
> +               }=0A=
=0A=
Could you remove this check?=0A=
=0A=
panic_notifier_list is exported to kernel modules and this check=0A=
prevents such users from using this feature.=0A=
=0A=
Thanks.=0A=
HATAYAMA, Daisuke=0A=
