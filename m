Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F9A51F778
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbiEII6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbiEIItk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:49:40 -0400
X-Greylist: delayed 135 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 01:45:47 PDT
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D5C17B84E
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 01:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1652085947;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/kVMDohfijxrA6GLao/+q7NNSaAxPnsTEzrObM1QEwI=;
  b=YitRKa0jMHHzO1b9nZGT5Tc3eDqd1kEsnjte8uCs0GuAjtRbr1QADaJN
   owe34g4Q8Ug5g5mmafb/hLEi0ec9FIGDBLoG4RtWkYVl6GtcjogMZ013V
   Oi9iu49zgN5GTbOA544KjXK6f00vhlshoSNbbYGSJPM6yJvxONYVGAMrw
   0=;
X-IronPort-RemoteIP: 104.47.55.105
X-IronPort-MID: 70860795
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:Kli3ta4+r2gOgMI4H9f4hAxRtN7GchMFZxGqfqrLsTDasY5as4F+v
 jEdWGGEaf6KNmbyfdwnao7l9xsBvcWAmNE2GlZoryA0Hi5G8cbLO4+Ufxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG96yE6j8lkf5KkYAL+EnkZqTRMFWFw0HqPp8Zj2tQy2YXhU1vX0
 T/Pi5a31GGNimYc3l08s8pvmDs31BglkGpF1rCWTakjUG72zxH5PrpGTU2CByKQrr1vNvy7X
 47+IISRpQs1yfuP5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2FPxpi67hh3Q9+2dx
 umhurSOVTwpOfPVv95MCTtjCAgvF5Fe6Jz+dC3XXcy7lyUqclPK6tA3VAQTAtdd/ex6R2ZT6
 fYfNTYBKAiZgP67y666Te8qgdk/KM7sP8UUvXQIITPxVK56B8ycBfiXo4YAgV/chegXdRraT
 9AeZjd1KgzJfjVEO0sNCYJ4l+Ct7pX6W2IA+AzN+vtqi4TV5A546ZzKMfGEQcOtHf1MnXe5m
 Vqe+HusV3n2M/Tak1Jp6EmEhODVmjjgcJkPD7D+/flv6HWDy2pWBBAIWF+TpfiillX4S99ZM
 1YT+Cclse417kPDZt38WQCo5XSAuRUfc8RfHvd86wyXzKfQpQGDCQAsSj9Hdcxjt8IsQzEu/
 kGGksmvBjF1trCRD3WH+d+8pzSoODNTKnQefygaVggUy975qYo3g1TESdMLOLWuktT/FDX0w
 jaLhCsznbMeiYgMzarT1VnXiTWhjpvEVAg44kPbXQqYAhhRYYekY8mt9gLd5PMZdIKBFADZ4
 T4DhtSU6/0IAdeVjiuRTe4RHbavofGYLDnbhl0pFJ4kn9iwx0OekUlryGkWDC9U3gwsI1cFv
 Ge7Vdtt2aJu
IronPort-HdrOrdr: A9a23:rQ1sfqyJ60B9+dZq0ScsKrPxvuskLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN9wYh4dcB67Scy9qFfnhOZICO4qTMyftWjdyRKVxeRZgbcKrAeBJ8STzJ8/6U
 4kSdkFNDSSNykEsS+Z2njeLz9I+rDunsGVbKXlvhFQpGlRGt1dBmxCe2Km+yNNNWt77c1TLu
 vg2iMLnUvoRV0nKuCAQlUVVenKoNPG0LrgfB49HhYirC2Dlymh5rLWGwWRmk52aUIF/Z4StU
 z+1yDp7KSqtP+2jjfaym/o9pxT3P/s0MFKCsCggtUcbh/slgGrToJ8XKDqhkF8nMifrHIR1P
 XcqRYpOMp+r1vXY2GOuBPonzLt1T4/gkWSvWOwsD/Gm4jUVTg6A81OicZyaR3C8Xctu9l6ze
 Ziw3+Zn4A/N2KOoA3No/zzEz16nEu9pnQv1cQJiWZEbIcYYLhN6aQC4UJuFosaFi6S0vFqLA
 BXNrCc2B9qSyLbU5iA1VMfg+BEH05DUytue3Jy9PB8iFNt7TJEJ0hx/r1rop5PzuN5d3B+3Z
 W0Dk1ZrsAxciYoV9MMOA4ge7rBNoWfe2O7DIqtSW6XZ50vCjbql6PdxokTyaWDRKEopaFC6q
 gpFmko/1IPRw==
X-IronPort-AV: E=Sophos;i="5.91,210,1647316800"; 
   d="scan'208";a="70860795"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 May 2022 04:42:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YR23JBKeG02epImxgjflKndIYniPOnRvyvoHWPLfYq4AVwuPFuz6AsY8od8iET3T/U+YpJ4UQhVq4OYspR12gbpdFFaSJ83WmqHwpyJieofmQBjW1lNGttc0K92EWDt2HABijbp+TnKSE1P+27NXC76WQ/lx9c52SGoh2sBxdRgCtrBeAIKq6nZ6OtXSTS1yu1mcFPWZHUaehGB9sebI/LYFeNQKP+OLqEd6CSdGUrMdj62ZxYfSIfDHJE5HQEeJgGvOnpOV0qyXQWtSEK9CJDtlNBlCsH3X7gUUgFVGpFc8NxVvd5jucduHvGB/xGb9KrJaBhfo2dZcvKGhQZrfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Drd8/4xtkZhH7KNfYnWw0NfKtXeJLp5V3qr0IHqLIA=;
 b=j4UNI5rFHZbPKs6v5bOQFp/LvxO4alSPd63tdwdxSMZtsIF5LPDPcnhyWuYnMNHukscYjKNKEA9o1Jxyc+nu3h2YUjdAklE3ygh8geYHSwsrkaNtpBbuLr8P7ti3nFvDrv9o1EOXkF1PRjHld4WDZ2TR+0Td8oBtmfNMSyNYXtH7WzWWGuuUcGPIppxjT9gf3JGzd4Apv7591iC3IPYF6oqa0F5gBV13EEe+8TGhplKB7IiHr4Hkqzy1HPXDvB2gPax+59ocmGRF5i9/tED1UR+iBvl/f3z/43XbodhGir/r5Mh5SNu3f15oEtsscxTPWWCoXCxeYziUISx6ZivtOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Drd8/4xtkZhH7KNfYnWw0NfKtXeJLp5V3qr0IHqLIA=;
 b=ux8xwY4qu1pCEMh18xd/Tbm3e7WcudqDjGpf95kzi1XbZQrI/AyNZsq05aRQDbW2uMWPeJlJ212NXiLGkTmWBMTnc3xTuiiZCMWYA0igWBde80rNZN2sqUr8j4Nzk9I6nBNYnOyTP6hVc1pDXmA9J0jzvm2QC+xjc57TpCtqhYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from DS7PR03MB5608.namprd03.prod.outlook.com (2603:10b6:5:2c9::18)
 by BN7PR03MB4404.namprd03.prod.outlook.com (2603:10b6:408:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 08:42:25 +0000
Received: from DS7PR03MB5608.namprd03.prod.outlook.com
 ([fe80::5df3:95ce:4dfd:134e]) by DS7PR03MB5608.namprd03.prod.outlook.com
 ([fe80::5df3:95ce:4dfd:134e%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 08:42:25 +0000
Date:   Mon, 9 May 2022 10:42:19 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 13/21] xen/blkfront: use xenbus_setup_ring() and
 xenbus_teardown_ring()
Message-ID: <YnjT6yoLejScEzf5@Air-de-Roger>
References: <20220505081640.17425-1-jgross@suse.com>
 <20220505081640.17425-14-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220505081640.17425-14-jgross@suse.com>
X-ClientProxiedBy: MR2P264CA0018.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::30) To DS7PR03MB5608.namprd03.prod.outlook.com
 (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a66d1586-8db2-473d-924f-08da3197d76a
X-MS-TrafficTypeDiagnostic: BN7PR03MB4404:EE_
X-Microsoft-Antispam-PRVS: <BN7PR03MB440474CBACA6AC0BAF143D548FC69@BN7PR03MB4404.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GH6rXwjQ16cKRI5UlOK1GtIx1H1urpG7g8mxc6JQ4Gjymy7K+1P3BY3jhGezz9nxeixC0LC1Zsqs9WNP3ARkzs4sE0eSygoKL032Zl+JJ8ZJ5/lBPIgPxiKIGG05UXwBRE06xzf8I/fj/eR14ipbfgWaT3iHE8l8P1LVlDY31gX+5DZYPoc6y0RWunBp77Q0+C4o8HeoKB1w0WNEOOsSzYtVX+zCOVDARD4nRBoplEDCYTkFTJvq/hzhTpX/FS4l9Pe7PNj/1xhS8RfYr8/nzCFUaEn+5/4GdMgTJ0QryT4rGEI4XZ3Vl3A7tzE49oWtMMeeDm6mrxx2v0oYpWEESFuJI5elkrVQo0Aq0v3/1YaPRlebDkf+8w45vph/jz1qmvto9Vk1JU8Nd1iHXr1f8QO+xX2dZRvsydA5kCc9+wq4H/TFTuCjoOOGngmgJZq2Dg3kopOCbu6fgksKuFRqsNlA4182ev2ApKRDXVnC2RCU0azSQANweN05XSfhUb4wTkrzlkjITcjtNvSFtZ98YR+54MjElwX5xkNJDsKrXJsZNI4h/wTmkhZHXK5aBMT4L7lSLJ6UEsgQE2yhcL2JPlyLMbVah8UX9aEA/jzChCPUGs+3+Jote8Tums3nk+T5wciikkf7hEkJr3xg/Nka6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5608.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(5660300002)(9686003)(6666004)(6512007)(6506007)(38100700002)(82960400001)(6916009)(26005)(54906003)(85182001)(33716001)(8936002)(186003)(2906002)(558084003)(6486002)(508600001)(86362001)(4326008)(316002)(8676002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzdlTFRoMU1aSk9JUDU3dnMyU0dWT1A2Mnltek96K3VSVlRRVjNyUmcxd01C?=
 =?utf-8?B?eDZSWUJkVVR4RzVDdlJWZzEwd0s5bDByTzZhUFUzMmRYL01sTlpmdUFOczBu?=
 =?utf-8?B?NW1hTUg1elEvUVlQdzlwS3UxUE9UM0lKdkQ1b2F4SXpPby9xUzdmMzNua0U3?=
 =?utf-8?B?S21YUEw0UkxwU0p1YTZaWmYwMTBoSGFucEcyZXhRNDNldWVKVHU4SS9MT3lC?=
 =?utf-8?B?S01ueXlxdlg3cGRSQW1zMUVKdjU0MjhSeDRFOWxLSEdNSHVVc0JVUVl3UEMw?=
 =?utf-8?B?azluaXcxSHJXcVNBMmpIVlpnYzdCb3h0NFhPRktTYWxXTmpnak5SYzEyQW05?=
 =?utf-8?B?WFA4dW92MXl6eDZZUFQyU0lxaVVtRW5jdVdQR0Z3eVRaSEZCZWRWTmtIQ3hF?=
 =?utf-8?B?aEtuK1FlMlcwb2o1VWg5ZzZzZkpHRHB1NEZ4S3hKcTcvQW45S2RUYzZrY2tO?=
 =?utf-8?B?ZjVPWm5KUGZCY2NQK1lZeXdlVk1FQ1pkN2hVUzg1TnpmS0o3MEZCY09Ccnow?=
 =?utf-8?B?cmN0WHYrV3l0d2FkeVlpekhsdlhhT0t3aExXOXo5ODF0eVNKUE9GRUlZNThw?=
 =?utf-8?B?ZnZVOUlkN254WXNNdk1JUG5FWmJzOHVzNnlSd1BZSWhOSjJEY240azQ2N29r?=
 =?utf-8?B?R0YzTTFuRndEQXYza1Bvbmw4UW5nT3lqT0IxVnhxa215YXp4VzJBY3Z5azlM?=
 =?utf-8?B?YS8xZ09CdHFtOWcwOUpyN2hGelcxM2ZiN21XbG5PVThvK2xSdDBCaVlLV3ZH?=
 =?utf-8?B?QU15M3V2bk1QY2tuWWxyRVZkalBoNVpxVG8xMThaSjNzaWlxRE5WN0xxM0Vi?=
 =?utf-8?B?YWlNeUx3WkNSN2tmR1BYVkVnbm9rL3J4Y2JsWFRDZEJzZXJiZEdCRkVGR3RR?=
 =?utf-8?B?bFNRbTBNWjRTZ0JvVjVSeVducXBKZVozMDllVGRpektZeDRqZWNpYTJ3bFpn?=
 =?utf-8?B?ODJycERlUlBmQnpKamdCN1BjZzlmcXh4YVVjVlU1L0c1RXdmRGFYcmFpVkx5?=
 =?utf-8?B?eXZMbkdQdlE3dHBLbkttZVlKRnAvbWFUUHNTdDYxVHBFMjlaaUE3bkxpdS9S?=
 =?utf-8?B?YnNRUndMOTVHcmI1S1ltbmRnTzAybWk5OUNraGcwelJBaG9HeitBSmlVdW1S?=
 =?utf-8?B?TlhIaTduMlFlL2Q4VGswd21XamFld3hsK2tIQUdWTU1qMFNvTFViTHpvU3NO?=
 =?utf-8?B?UWNaNTVrYkg0QjkxV2RKcEp4TWxxYkt1eHRYM2Y1RG5uTktWeGE1aVNmcWRG?=
 =?utf-8?B?WC9NaUx2dUlKSVZOdkswb2dyR3JMN0k5dDhUcXVDVE1UbGlXWklCTWtzQXNQ?=
 =?utf-8?B?WWd0eFFvUUt0WnhrVUU2ZUZ3bkRBb0hoUFRlMWF2VHVlZlJ2K3hqZnlmbTRU?=
 =?utf-8?B?dUU1enpKZ3JqTDVaTzVkL0NoR0wrNDFuVldWbjNRT3hEM2hXcEFLWnN5bTdK?=
 =?utf-8?B?akE4eU4zZUhJL0FFNjk4cW8vQkR6bHJsdi8rQXpKVU1mL1pXOHBLRlNhemxz?=
 =?utf-8?B?aWVrRCt0SThna3NEczBIUENZbWwvVVhZcG53ODJ5bnZiM3phOTVmMWhlQVlZ?=
 =?utf-8?B?WDBZMGV3eDZmRHBFZkJ2UHkvU1RzbGE1OFBlbmk1TDkyblpyMjNlY2Q3aDYy?=
 =?utf-8?B?dFVHd2lyaGtjQXZoZ1F4RXk4Q2E1Vjdlb053bm9ydU1ZbHFoemRwd2RuQXg3?=
 =?utf-8?B?T3laMU5WL3NQMjlUTjFDU2lrQURuRDhpYnh2S3piZUdZMEtYU282VysrRjJC?=
 =?utf-8?B?Rjh2dkNTN3R3ODVqQ3RrMU5iSVZLTC9WY3htL2FPdjFQTVN6RnVwSUdIcXZN?=
 =?utf-8?B?RDlvd3BuVFNuTUh1SGRiQjYzZjhHMUdxZlE3cEJwUDBZcnFEZHU0bFJEYklR?=
 =?utf-8?B?T0l4ZGhHblNhcW83dnVYQ1ZFWGl5WFdhelZHSlEvQ2gxM3NiMFUzOWhZWk1N?=
 =?utf-8?B?VVdPOUE5SjVTQVR5aDd5a0lVMXdTTWdRYm9YK05na2xFRkRYSUlXc1lJN05v?=
 =?utf-8?B?ODZNVTV0SHZoR0d2NndNb1FYOU9NZzFIWkJZUWh3YW1qT3hEdGRBcUwxZmR1?=
 =?utf-8?B?SkRGMVNLdHB0MkRCYzNCQnc4dlAzb25paFF3eFN4a0U4WU5oSklCblEvMzVI?=
 =?utf-8?B?c01JbG8yNFdRbHNscEE0WmY3NkVuak5qU3drTEtrN2J1RENZdDBxb2RPc0R2?=
 =?utf-8?B?cERCL1VtRHltWXpLcGoramJZOW1BRFJscmxwK3NSMUdBRFFYSkJiL2tnRWtM?=
 =?utf-8?B?VUpnQzZlaG03dnZOcWVMZ3dNc0I4Zk1oSmt4TXQvS1NiUmE3WTE3Y0J6bjYv?=
 =?utf-8?B?SEhYelNOblhmU3J0eXJ5aCtrZ1NZYkdSWmxPV1gyTk5PZS9PaXMyNjV6eTNr?=
 =?utf-8?Q?J4go+lCItpgu3sQA=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a66d1586-8db2-473d-924f-08da3197d76a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 08:42:25.1348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQPC8ryiS3dt5PMJMLabGCoTrfyVU+9aXZ9Tqjx/s30gjmrb0PNAXkRs6g/TuaB1g9z9frmm/mW2eiSEXvDjsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4404
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 10:16:32AM +0200, Juergen Gross wrote:
> Simplify blkfront's ring creation and removal via xenbus_setup_ring()
> and xenbus_teardown_ring().
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.
