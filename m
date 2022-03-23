Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F844E5072
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiCWKhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiCWKhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:37:52 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10059.outbound.protection.outlook.com [40.107.1.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F259F25E81;
        Wed, 23 Mar 2022 03:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K04gbzpI6d8G5GmjvHuJlOTkmCABNGdUMSFuGVQhYts=;
 b=rSDEeC8nsY4wZ0rFt1iACQgp0FH+V0GC33yxqpwB0z6RX8J+sji8A1E/Q9Iia8eqSmXGjvjbtrUBaZZRb5X1r3UryOYI1De59R6LP9Hksb9cWMHThzCd1rq3G6d7nOgVvwJhcwFu7cO6PjBFHr+BXqX6a8cKuKag7mqpARIkX3g=
Received: from AM5P194CA0006.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::16)
 by PA4PR08MB5997.eurprd08.prod.outlook.com (2603:10a6:102:f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 10:36:08 +0000
Received: from AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:8f:cafe::29) by AM5P194CA0006.outlook.office365.com
 (2603:10a6:203:8f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Wed, 23 Mar 2022 10:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT014.mail.protection.outlook.com (10.152.16.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14 via Frontend Transport; Wed, 23 Mar 2022 10:36:07 +0000
Received: ("Tessian outbound 63bb5eb69ee8:v113"); Wed, 23 Mar 2022 10:36:07 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 01e717ceea646f11
X-CR-MTA-TID: 64aa7808
Received: from 30ac40f0aa83.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 73A0FFB5-F62F-4E2C-A365-30C7574018D1.1;
        Wed, 23 Mar 2022 10:35:56 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 30ac40f0aa83.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 23 Mar 2022 10:35:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJfucM3ccdEUk0gSChLdrmXmvSUrvxIh9DwQkrORW4L2tqSz5CEm8MFilksCiqNWX2usbW7iyvm1PsW4G7iGME0CN7bee7QUtOUNeAmneVjhm1IfLd+Z+kuP0AIx7o0OB+Vo0yDQG6xLhJf4v/eW4tF1hZnI94VY9u9GPqH1qtY0xFniIVNO6VgOyY3yaoIdD4aahQCfVazxuseNyJCak0K3SIxq3zpaiPznU+cfp4WXkjTjEFWGSeQR7J5QsZZXlZSXU1Va9FmTR7ozkwr8B2pngybEysa1aX81ox4sMYozwNuFGvry4nDTT6oLgMKg5yvL4/aYRAozK0P0j54gHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K04gbzpI6d8G5GmjvHuJlOTkmCABNGdUMSFuGVQhYts=;
 b=EbriUKLMV3xfUU6gt8TK48FKPY0fWOfC+qibqWxHlyEK8vnKrYXRL/p7voYbCRMdrcjndL4NRZT9NwTjaR5JgxeZ4eUjqICE5BAJ+bi+3oT4RokpHtPQzabPR/LBZ0FYurkKHE1RpF1cp2DAhyRbojs7e4DHWmvGz0LmT94Y5BFYdJGaXfq6/Rnb4YO7VWv0BSkfY0N7rNzcfHAWCN5RXYWgvge9fEz6RjncGiDiSNBknZT32p+T7ii3g3wxZmOS+YuuPM+Lub0h43inLTjQSBnAV5hZl2lPhqf2hfmOLC21Y6PhAVVRJ+xdMhcEmTjpH4UW6ADmZRWjv6/AADH6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K04gbzpI6d8G5GmjvHuJlOTkmCABNGdUMSFuGVQhYts=;
 b=rSDEeC8nsY4wZ0rFt1iACQgp0FH+V0GC33yxqpwB0z6RX8J+sji8A1E/Q9Iia8eqSmXGjvjbtrUBaZZRb5X1r3UryOYI1De59R6LP9Hksb9cWMHThzCd1rq3G6d7nOgVvwJhcwFu7cO6PjBFHr+BXqX6a8cKuKag7mqpARIkX3g=
Received: from DBBPR08MB5882.eurprd08.prod.outlook.com (2603:10a6:10:200::15)
 by AM4PR08MB2914.eurprd08.prod.outlook.com (2603:10a6:205:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.21; Wed, 23 Mar
 2022 10:35:54 +0000
Received: from DBBPR08MB5882.eurprd08.prod.outlook.com
 ([fe80::e9dc:17b2:4646:6f63]) by DBBPR08MB5882.eurprd08.prod.outlook.com
 ([fe80::e9dc:17b2:4646:6f63%7]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 10:35:53 +0000
From:   Al Grant <Al.Grant@arm.com>
To:     Mike Leach <mike.leach@linaro.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>
CC:     "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        James Clark <James.Clark@arm.com>
Subject: RE: [PATCH 00/10] coresight: Add new API to allocate trace source ID
 values
Thread-Topic: [PATCH 00/10] coresight: Add new API to allocate trace source ID
 values
Thread-Index: AQHYMy4eUNeaPHjeRUuY76QwKpbH6qzLTPUAgAAPXYCAAA/TgIAAH2WAgABKEYCAAP+lAIAABLxA
Date:   Wed, 23 Mar 2022 10:35:52 +0000
Message-ID: <DBBPR08MB5882C01EF07A2ABB4BC6F1FA86189@DBBPR08MB5882.eurprd08.prod.outlook.com>
References: <20220308205000.27646-1-mike.leach@linaro.org>
 <e890feb0-9f90-c0f2-e5f0-10ed5dbe6d81@arm.com>
 <CAJ9a7VhzwMri1Lz5mtO5um3-tT9=GUpGN3cHJhkW5TTsbOKbgQ@mail.gmail.com>
 <639c902b-535e-8627-de04-9bcbbdc98ed5@arm.com>
 <CAJ9a7VhyFj9vcUFjrwtqn47LbdqHp+gQCvtDBNX69-=Y5-2iag@mail.gmail.com>
 <17215ebc-dbf2-81ca-7ef4-b4ebc3cb9d28@arm.com>
 <CAJ9a7VjZm=QAKhPJwewO3i3Qyc3C-jbzJKSoCk+Gr+_FXGR9oQ@mail.gmail.com>
In-Reply-To: <CAJ9a7VjZm=QAKhPJwewO3i3Qyc3C-jbzJKSoCk+Gr+_FXGR9oQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 5eff14de-127e-420f-a887-08da0cb8f09b
x-ms-traffictypediagnostic: AM4PR08MB2914:EE_|AM5EUR03FT014:EE_|PA4PR08MB5997:EE_
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
X-Microsoft-Antispam-PRVS: <PA4PR08MB59979EE8AF737C433C464C1386189@PA4PR08MB5997.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ti1VEvVdNSwxEQyspgOLtu1WmGqbKlYbdzmWfIvYTdN7KExVX+bb9ji+CneegiF/j+TgwV3BnU6PbdHY7nAGMUoUoFbFRmDh17B3lIdKDS/ZG1S6xpuVbX2+yzWieJeD36p3Xg3pkQJTCBG9jV3L57tgqq9ceVlKIDfg6mOD9VsPLCaUT6p7ObV0Y/u5z/R9LMrKDdwDV0Lxh0lyzCy5cWqVGJDcFYT1fY8EKtHJ/xCoaqnaT9fWVnlUEVcvnRT4JGOc0jmQ5FAmCFhmrT7b48lVUmwtZXcBBV4u1ytGehfkqjvVlzPfuwE7Ab2kYkyvwhXGiO+oLWUfvC7F3ueKt8tG4C+34H/Hg2zJ/kz9NeIelO6bAY0j9o74kuytEjf7D2H4y6QrNz5646rMFbCfBhMtGsweQrEFM6XqAMmbSHt+fVqqHHqpWyIDBxjBnGA/8MMFFCHbS5YWWARE6WNIFcq2x4gY3X80OwyQVIZk1iiGaTXwMsGoUhz439bqm1jm8vGIc2khU9axM2MY9Fm3a1vYs93geVOJgxgJtbh+aurnDyy/xVH1UmiP/MhDjKHnsRcGj5EKHG8NsEnpOjbn8O/s6o6PSRk8AmxOA1VIVrq/U9Mcz64n7nJj3MWqA8xzCAvmag3a7ErxSJ8hzSdoZ9qppAXyewH6UlOLJlNdKvAyLNEyd5hzn9XnQ9dzMhQULPchWAyPP6b29CQHT5Ya4Q==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB5882.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(9686003)(6636002)(316002)(55016003)(83380400001)(64756008)(7696005)(6506007)(8676002)(71200400001)(54906003)(110136005)(66556008)(76116006)(66946007)(53546011)(122000001)(8936002)(66446008)(66476007)(4326008)(33656002)(5660300002)(52536014)(38100700002)(26005)(508600001)(186003)(86362001)(38070700005);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2914
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: adfd9bfb-6032-4154-95fc-08da0cb8e7eb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7h4rDkwA36p0UHS0AVuHqAaeCDiQ+5fyC4uBGvgmKLoiyo1FbBUZkhKD4CKNq+/QKdi8TWKa0JpqfJ32T7tTu3feNpcOe80kfDCebmD77lvPk7xVZvRo/5AmFlipB9eQX6gsAJIIk+XSwVKARZ+4fn5Xp8q8cZPkbUVYNBMpYx1Ksd5SVfMb0HFsf0Kais9Chzo5el6JXefLjMNeMskrrxf+gpW1Xggr7DcZNnwAeDWunEGXAKhbwNCsw35rks6ktvUI5Enj+DGWA9IE8fP1kq3g1tPxngeQ5BtGRdmPh3DVzKwpw9onVUtk9ZH4QExfEFPzRXVJXbxE5mnsktDc3bkPHfU3ILcRlf1s92jCHGnFXZbCL5E/YIXkYnqyfNAGsXVvbb0hTG21lofjinhe/NsoNMjeOY3UxtCn8meBwYven4E8vxRqm80vjjfXpm36kZhCf0KF7C7nvYtdLJ4eKFdTuu3fgbFqq+NE1M2gwe/KnP8yne1LqikZafyjGjG7I/Kt7IMejDgcqPePofvdP5ADCIyspcrWfvY+RTPcP4dm2IDWVnSYmKMyKnk3c2VLhbEptgajAQalUlSQIWrpNl6Z7bxrdLQKX54CVE1K/B9lmmAwYHdpkfs83st4wXgmZNZDZEwi7dMpzM68c2YoyNzcHs+CE1jyZsuUtASTOOydIBsnVhHrCTV2eaA2DNNb
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(9686003)(7696005)(86362001)(53546011)(36860700001)(52536014)(2906002)(508600001)(6506007)(26005)(83380400001)(47076005)(82310400004)(186003)(336012)(5660300002)(8936002)(55016003)(356005)(81166007)(54906003)(450100002)(40460700003)(6636002)(316002)(110136005)(33656002)(70586007)(4326008)(8676002)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 10:36:07.3970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eff14de-127e-420f-a887-08da0cb8f09b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5997
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mike Leach <mike.leach@linaro.org>
> Sent: 23 March 2022 10:08
> To: Suzuki Poulose <Suzuki.Poulose@arm.com>
> Cc: coresight@lists.linaro.org; linux-arm-kernel@lists.infradead.org; lin=
ux-
> kernel@vger.kernel.org; peterz@infradead.org; mingo@redhat.com;
> acme@kernel.org; linux-perf-users@vger.kernel.org; James Clark
> <James.Clark@arm.com>
> Subject: Re: [PATCH 00/10] coresight: Add new API to allocate trace sourc=
e ID
> values
>=20
> Hi Suzuki,
>=20
> On Tue, 22 Mar 2022 at 18:52, Suzuki K Poulose <suzuki.poulose@arm.com>
> wrote:
> >
> > Hi Mike
> >
> > On 22/03/2022 14:27, Mike Leach wrote:
> > > Hi Suzuki
> > >
> > > On Tue, 22 Mar 2022 at 12:35, Suzuki Kuruppassery Poulose
> > > <suzuki.poulose@arm.com> wrote:
> > >>
> > >> On 22/03/2022 11:38, Mike Leach wrote:
> > >>> HI Suzuki,
> > >>>
> > >>> On Tue, 22 Mar 2022 at 10:43, Suzuki Kuruppassery Poulose
> > >>> <suzuki.poulose@arm.com> wrote:
> > >>>>
> > >>>> + Cc: James Clark
> > >>>>
> > >>>> Hi Mike,
> > >>>>
> > >>>> On 08/03/2022 20:49, Mike Leach wrote:
> > >>>>> The current method for allocating trace source ID values to
> > >>>>> sources is to use a fixed algorithm for CPU based sources of
> (cpu_num * 2 + 0x10).
> > >>>>> The STM is allocated ID 0x1.
> > >>>>>
> > >>>>> This fixed algorithm is used in both the CoreSight driver code,
> > >>>>> and by perf when writing the trace metadata in the AUXTRACE_INFO
> record.
> > >>>>>
> > >>>>> The method needs replacing as currently:- 1. It is inefficient
> > >>>>> in using available IDs.
> > >>>>> 2. Does not scale to larger systems with many cores and the
> > >>>>> algorithm has no limits so will generate invalid trace IDs for cp=
u
> number > 44.
> > >>>>
> > >>>> Thanks for addressing this issue.
> > >>>>
> > >>>>>
> > >>>>> Additionally requirements to allocate additional system IDs on
> > >>>>> some systems have been seen.
> > >>>>>
> > >>>>> This patch set  introduces an API that allows the allocation of
> > >>>>> trace IDs in a dynamic manner.
> > >>>>>
> > >>>>> Architecturally reserved IDs are never allocated, and the system
> > >>>>> is limited to allocating only valid IDs.
> > >>>>>
> > >>>>> Each of the current trace sources ETM3.x, ETM4.x and STM is
> > >>>>> updated to use the new API.
> > >>>>>
> > >>>>> perf handling is changed so that the ID associated with the CPU
> > >>>>> is read from sysfs. The ID allocator is notified when perf
> > >>>>> events start and stop so CPU based IDs are kept constant
> throughout any perf session.
> > >>>>>
> > >>>>> For the ETMx.x devices IDs are allocated on certain events
> > >>>>> a) When using sysfs, an ID will be allocated on hardware enable,
> > >>>>> and freed when the sysfs reset is written.
> > >>>>> b) When using perf, ID is allocated on hardware enable, and
> > >>>>> freed on hardware disable.
> > >>>>>
> > >>>>> For both cases the ID is allocated when sysfs is read to get the
> > >>>>> current trace ID. This ensures that consistent decode metadata
> > >>>>> can be extracted from the system where this read occurs before
> device enable.
> > >>>>
> > >>>>
> > >>>>>
> > >>>>> Note: This patchset breaks backward compatibility for perf record=
.
> > >>>>> Because the method for generating the AUXTRACE_INFO meta data
> > >>>>> has changed, using an older perf record will result in metadata
> > >>>>> that does not match the trace IDs used in the recorded trace data=
.
> > >>>>> This mismatch will cause subsequent decode to fail. Older
> > >>>>> versions of perf will still be able to decode data generated by t=
he
> updated system.
> > >>>>
> > >>>> I have some concerns over this and the future plans for the
> > >>>> dynamic allocation per sink. i.e., we are breaking/modifying the
> > >>>> perf now to accommodate the dynamic nature of the trace id of a
> given CPU/ETM.
> > >>>
> > >>> I don't beleive we have a choice for this - we cannot retain what
> > >>> is an essentially broken allocation mechanism.
> > >>>
> > >>
> > >> I completely agree and I am happy with the current step by step
> > >> approach of moving to a dynamic allocation scheme. Apologies, this
> > >> wasn't conveyed appropriately.
> > >>
> > >>>> The proposed approach of exposing this via sysfs may (am not sure
> > >>>> if this would be the case) break for the trace-id per sink
> > >>>> change, as a sink could assign different trace-id for a CPU depend=
ing.
> > >>>>
> > >>>
> > >>> If a path exists between a CPU and a sink - the current framework
> > >>> as far as I can tell would not allow for a new path to be set up
> > >>> between the cpu and another sink.
> > >>
> > >> e.g, if we have concurrent perf sessions, in the future with sink
> > >> based allocation :
> > >>
> > >> perf record -e cs_etm/@sink1/... payload1 perf record -e
> > >> cs_etm/@sink2/... payload2
> > >> perf record -e cs_etm// ...      payload3
> > >>
> > >> The trace id allocated for first session for CPU0 *could* be
> > >> different from that of the second or the third.
> > >
> > > If these sessions run concurrently then the same Trace ID will be
> > > used for CPU0 for all the sessions.
> > > We ensure this by notifications that a cs_etm session is starting
> > > and stopping - and keep a refcount.
> >
> > The scheme is fine now, with a global trace-id map. But with per-sink
> > allocation, this could cause problems.
> >
> > e.g., there could be a situation where:
> >
> > trace_id[CPU0][sink0] =3D=3D trace_id[CPU1][sink1]
> >
> > So if we have a session where both CPU0 and CPU1 trace to a common
> > sink, we get the trace mixed with no way of splitting them. As the
> > perf will read the trace-id for CPU0 from that of sink0 and CPU1 from s=
ink1.
>=20
> I think we need to consider the CoreSight hardware topology here.
>=20
> Any CPUx that can trace to a sink reachable by another CPUy must always
> get trace IDs from the same pool as CPUy.
>=20
> Consider the options for multi sink topologies:-
>=20
> CPU0->funnel0->ETF->ETR
> CPU1--+^
>=20
> Clearly - in-line sinks can never have simultaneous independent sessions =
-
> the session into ETR traces through ETF
>=20
> Now we could have replicators / programmable replicators -
>=20
> ATB->Prog replicator->ETR0
>                                  +->ETR1
>=20
> however programmable replicators use trace ID for filtering - this is
> effectively a single sink on the input, so once again the Trace IDs must =
come
> from the same pool.
>=20
> Now, we could have independent per cluster / socket topology Cluster 0
> CPU0->funnel0->ETF0->ETR0
> CPU1--+^
>=20
> Cluster 1
> CPU2->funnel1->ETF1->ETR1
> CPU3--+^
>=20
> Here cluster 0 & 1 can have independent sets of trace IDs as their respec=
tive
> cores can never trace to the same sink.
>=20
> Finally we have the ETE+TRBE 1:1 type topologies. These could actually no=
t
> bother allocating any trace ID when in 1:1 mode, which should probably be=
 a
> follow on incremental addition to this initial set.
>=20
> So, my conclusion when I was considering all this is that "per-sink"
> trace Id allocation is in fact "per unique trace path set" allocation.

The id pools can't always be defined statically in all situations.
E.g. if you have 128 CPUs each with their own ETR, and also
replicated into a funnel network leading to a common ETR.

This topology supports (at least) two distinct modes: (a) all CPUs
enabled for tracing to their own ETRs (b) a selection of CPUs
(up to some limit), combined together. Both are valid dynamic
configurations. Perf might have a preference on which one to use,
but both are valid.

But there's no static id pool that works for both. The pool for
(b) has to allocate to some random selection of 128 CPUs,
from only around 120 numbers. The pool has to take account of
which CPUs are selected.

So your comment "any CPU that can trace..." has to be interpreted as
"any CPU that can trace in the currently configured dynamic topology"
rather than "any CPU that can be dynamically configured to trace..."...
is that what you meant?

Alternatively, we could just declare that such systems are too
complicated to support, and say that we wouldn't support the
use of a global sink that (statically) was reachable by 128 CPUs.

Al


>=20
>=20
>=20
> >
> > So my point is, we are changing the ABI for perf to grab the TraceID
> > with your patches. And clearly this approach could break easily when
> > we extend to sink-based idmap. So, lets make the ABI change for perf
> > scalable and bullet proof (as far as we can) by exposing this
> > information via the perf RECORD. That way any future changes in the
> > scheme won't affect the perf as long as it has a reliable information
> > within each "record".
> >
> >
> > My point is, let us fix this once and for all, so that we don't need
> > to change this again. I understand this involves more work in the perf
> > tool. I believe that is for better
> >
> > Thoughts ?
> >
>=20
> My preference is the incremental approach.
> Fix the trace ID allocation issues that partners are having now, then upd=
ate
> to the perf record approach in a separate follow up patchset.
> Then when we start to see systems that require it - update to using the p=
er-
> unique-path trace ID pools.
>=20
> Regards
>=20
> Mike
>=20
> > Suzuki
>=20
>=20
>=20
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org To unsubscribe send =
an
> email to coresight-leave@lists.linaro.org
