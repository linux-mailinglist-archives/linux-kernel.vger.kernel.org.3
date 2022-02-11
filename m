Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE944B2FC8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbiBKVrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:47:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiBKVrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:47:01 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C1BC62;
        Fri, 11 Feb 2022 13:46:59 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21B5TwJw021781;
        Fri, 11 Feb 2022 15:46:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=PODMain02222019; bh=VdRs1St9Lo5RJL4Jz2RH4il3nWyWL71eaEfNlPie8zU=;
 b=MyJhikD21NOp4HqiYn4TC1ELJ0D9kZolI6jauXrSr3MAHtiEiEUN10MymiK7MJiqQtz7
 GhBILdVh+u1M5If295cGJ6/RraBFIBt9Q3pIizoD+zpeYQXvtFfeZfYLtmXhJ4nnsIUc
 mwG0pzCw5hMNkxPNPwNAJAP2bb66iSVRsVYyEEhqaniXAVolJzZPkWBqX/RegQs1sPoz
 JKr0qcmjbxiVxn9Z6ji0Rv5l6bc1jkEecIeBPHQxG/E9IE0J0VBsM9Fd0N6sDqyuY5QH
 ows9Cx3LtKRWqpcSpjTDRXqeH7pcC4vhTzwTAsXhvJq9BiqiZUMEKknwCPTgsGz+Ztg1 VA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3e4brbbhr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Feb 2022 15:46:56 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 21:46:54 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 11 Feb 2022 21:46:54 +0000
Received: from smtpclient.apple (unknown [141.131.79.34])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C1CE611C7;
        Fri, 11 Feb 2022 21:46:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [RESEND v2 1/2] power: supply: Introduces bypass charging
 property
From:   "Rivera-Matos, Ricardo" <rriveram@opensource.cirrus.com>
In-Reply-To: <20220211204309.apzep7w233vh7iin@mercury.elektranox.org>
Date:   Fri, 11 Feb 2022 15:46:52 -0600
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Content-Transfer-Encoding: quoted-printable
Message-ID: <7DD3FE07-445C-47BC-92AB-B281ABF67068@opensource.cirrus.com>
References: <20220210154108.641369-1-rriveram@opensource.cirrus.com>
 <20220210154108.641369-2-rriveram@opensource.cirrus.com>
 <20220211204309.apzep7w233vh7iin@mercury.elektranox.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Proofpoint-ORIG-GUID: U1WMV0pGFQp9qOY6lTPNN_esnf_DQfQ3
X-Proofpoint-GUID: U1WMV0pGFQp9qOY6lTPNN_esnf_DQfQ3
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian,

> On Feb 11, 2022, at 2:43 PM, Sebastian Reichel =
<sebastian.reichel@collabora.com> wrote:
>=20
> Hi,
>=20
> On Thu, Feb 10, 2022 at 09:41:07AM -0600, Ricardo Rivera-Matos wrote:
>> Adds a POWER_SUPPLY_CHARGE_TYPE_BYPASS option to the =
POWER_SUPPLY_PROP_CHARGE_TYPE
>> property to facilitate bypass charging operation.
>>=20
>> In bypass charging operation, the charger bypasses the charging path =
around the
>> integrated converter allowing for a "smart" wall adaptor to perform =
the power
>> conversion externally.
>>=20
>> This operational mode is critical for the USB PPS standard of power =
adaptors and is
>> becoming a common feature in modern charging ICs such as:
>>=20
>> - BQ25980
>> - BQ25975
>> - BQ25960
>> - LN8000
>> - LN8410
>>=20
>> Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
>> ---
>=20
> Sorry for the wait. This needs to update the sysfs ABI documentation:
>=20
> Documentation/ABI/testing/sysfs-class-power

Ack
>=20
> I think your patch description is a good explanation for that file.
> Also I obviously missed to point this out for the "Long Life" charge
> type, so please also add a sentence for that so that the property
> is properly documented.

As I understand it =E2=80=9CLong Life=E2=80=9D means the charger reduces =
its charging rate in order to prolong the battery health.

Is this a fit explanation?
>=20
> (Otherwise the patchset looks fine to me)
>=20
> Thanks,
>=20
> -- Sebastian

Best Regards,
Ricardo

<snip>

