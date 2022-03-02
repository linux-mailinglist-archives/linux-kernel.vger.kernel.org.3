Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257E04CA122
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbiCBJsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiCBJsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:48:05 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24A83152A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646214442; x=1677750442;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=liDamWG0etiZkIClSKlKXoOd+BLRAjLAouimcXl7Tuk=;
  b=Hjlp1btDF1YnHvw9Ka4dwzJ252hwQyHWkJSDLj+98iJTwwY+zdytNgE7
   h09ocrP4hXsHZGJHDUSdy3LsRE23aDo7QTOGyRrtffLzFGegNvuRzEg/A
   KpQsFn6pIDTdjYVn6F+ktkdGykBdoKIau7hWhgv9h78lk9jJzrH+Nqelw
   vhSlCfduqZS35BqFtoiiUqYkWbVo+P14gGoJy2FNzR0rl3PhVl5QuRXCf
   AeKhxw4k+xhBLcJ8oVx2X6UT1PISiuVZMxiOnEbwj/EeM2fP5CdIYNdeb
   lwGftzFdPws2t+FKG2rNJHNPnacgSIRECVSXx7y/9b/4/ipOKxraFiUin
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="253556550"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="253556550"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 01:47:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="778819085"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga006.fm.intel.com with ESMTP; 02 Mar 2022 01:47:21 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 01:47:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 2 Mar 2022 01:47:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 2 Mar 2022 01:47:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaVSOXdTm0oPJwQTJnBJn1H27+TZ2M4hXH3W9whQWJTpODR6aRKimOjhmS+tBJNLYUf7CP5Y9qvqNqTfPR9bNlrKPIiDUtMaAXP6PcmwHZUyZQxbJZG2b1ECvk+8v3ckuPcgQoAmJPO46r/p2IAUgeXq7EfWFuVGvYbslvt6wvaZnJA9hAU2+LxnGmILKyshZTrK2Hxa1nOnCSOOmKdzUTTl1BBj8zCDLJopNnlQ0vzkRJ02jGIfhKO+MU/yFLv1TdwbnUU2AXOaT49fyVy7ELvZvt1uk9C2pX7j06r0CbkfAHNxM4Yeve94penHbr6jKX61HN9SrJnMegdrkz3GmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhRrEgdMSRCUgouMDXsGN9AZq9DN0MJLY5YZUrajFw8=;
 b=FwIRkydEoRuE5/7VVujq5/a0SJG7/Hy/2EyoM/bhFRzClHz0iuAODr+j5Y8Q80ohb2HXq4hpa73sRz3z57d6DZ3aNbcY0VlLRhdW7IQRV8rGAfWDIHlTamTRssLegt9ANS8zzCgBQMViof/SXo3RKuqGMHdQ4amipVW3NVwKybrLCWJ+G4+NaQyh+KurYIHAgS8H19uGjPbv0gW6P0fDO16Mbu8GoYzXvS6XXIql2Quc3U+ktJviQT59EAG/gkxLkbUYzjGiVr7M3RVcml0wrH6hB49e0j8zSAFHr7/v/1Pe0TA3+i4otZIJGzb5DWsiZhUyvq2dR70VkriJ9OJD2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by MW3PR11MB4619.namprd11.prod.outlook.com (2603:10b6:303:5b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 09:47:15 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%9]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 09:47:15 +0000
Message-ID: <5f13b914-e309-49ee-4f98-c81780c478b9@intel.com>
Date:   Wed, 2 Mar 2022 17:47:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: drivers/net/can/usb/etas_es58x/es58x_fd.c:174:8: warning:
 Uninitialized variable: rx_event_msg [uninitvar]
References: <202203021333.mMJpWPzx-lkp@intel.com>
Content-Language: en-US
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202203021333.mMJpWPzx-lkp@intel.com>
X-Forwarded-Message-Id: <202203021333.mMJpWPzx-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0218.apcprd02.prod.outlook.com
 (2603:1096:201:20::30) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2349bc3-2f83-448a-088a-08d9fc31a1af
X-MS-TrafficTypeDiagnostic: MW3PR11MB4619:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MW3PR11MB4619786CAB43823CDDA263F8FB039@MW3PR11MB4619.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fgtQTfvGGIy0vIJ9h3ts2VGzkMMFdP+52yNyK5Bg8tvEKcdRTLeUmxi4zaFGDKU2e+SoKoaNpNtXmcwr0SUFD/wN3AfbNtGRnmU+y2sJp9MpoIcgfQlkF1pOBZYrbv0zWjdT9J5quJyo5a96vCnJvTR1VEUZvWG225UBM2pOpb4DAsq0D2QzD1WyyFiKD0FItGkdvWnqZs8qMGTReAYNqcWykTGrUn1rJFQGTHHImbphisSD5m/Jj8laTpo7fakY8Icu8EWUIMMhT3H35djzQ1TWwAM8KTh5lyd6e9V3i9NI33YOPiN3U9mxeP/mwCNRuSrPfRIZWsxh1KRCBj5u7NtSxmhIf3wFIIiXbpiQ3eY1sdCLXpYBGul+MNGZvMz6DOMwHoMvW+lMphKigiiMIlJOlcFxK3wkyvr8gSqgNHC4wXvq0rLwtp27PHhUZ/uXO6U4iysGG8iZFXbEJAs9AH3F1G2rJxTOvLLtzOfhn8MDM09GsfbUOoI8XDU0lPaMur7l84H/GuviuSyzfuXFdTrKBERSwBclAUe6TlyCbuK/E8xdXM8PTfImMz0zpKT325rLsLN8+KX4aATQ8Q2i9AT/0A+aCMdrc6dbo+Z+i/+WeVt6VnWPay0R/uYqz31mdmnw4k8t4UgYdYOPQdN5zKTeoi73X/3oePVdgzBzjQucSuFTGy2jXsOCv6JBdKR+csB3vRdsodqRyba5gDr6cWQ4Dz+zXxzIoCSm9LjGV/I6SDS5qgtV7nlHacJ6AVmlinnjo8k9VOuVII2Hs2kFIn14+eBU/o1GSldsLu1lFPaVC67eHweZc68MSGCq/CW+ng06rAvzuNlVTp1GvvWGTwWuGDOWT/++7m6uXRYKeQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(186003)(2616005)(36756003)(31686004)(6512007)(38100700002)(316002)(6666004)(66556008)(8676002)(6506007)(66946007)(2906002)(5660300002)(66476007)(82960400001)(4326008)(8936002)(86362001)(508600001)(31696002)(966005)(6486002)(83380400001)(6916009)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTVQQWJNZ0dONTNxblkzelNYU2dzdUtCMEZLQ1hvVUl3TGwxbGp4UkoxN3BN?=
 =?utf-8?B?SGx1aTN0MVhOV0svRmxDLytiM2VtMWhlbDY3Um5XUEVZSk5iZjRTeHV0RGFm?=
 =?utf-8?B?VXQ0Rjl6Z1grZEhMS1ZtTnNaT0Vac1NoeXNZVlBIZXUybDlUSnVmQzZ4TVRZ?=
 =?utf-8?B?cFdDTVdMYjNqZ3dFcEJjSEdFQ3lGcTZaanppUURWK3VON043RmVvMWovaHdO?=
 =?utf-8?B?eS8rWmxWS3gyamFTSE84VHlBVEtZL3g0M2xCME5CUmc1U0ptUmppZ1FiQ21o?=
 =?utf-8?B?SkRXM0NRbWRDbitEN0R4Mmh2SFBCVktGNU9OcnhySU9MN0JrU0FOUXphTTB3?=
 =?utf-8?B?MlhQc1ZCSGZuS2JEeWdxYjBRWnl6dE9pN1d4VTVXd3d2bEZINVNmc2hMOWxQ?=
 =?utf-8?B?MldhTlh0WGs0bHdzTWNtc3htMlF0dlRKYXdsZ1JmaFlHTExsRnY0VlVYZ0s1?=
 =?utf-8?B?M2U3cWt5QWt1cUwyYVUzdDZkNlpzbmlMczlUYm1xWVJVWkFKRGg0OG9PLzlm?=
 =?utf-8?B?TUdOVUZHNEdWOG0waEdaTWxnRjFYdmI2MlJsUTkxVWRtUFBuSkxKbXMvK1pW?=
 =?utf-8?B?VmxWY0VtWnpWWm84OGhha21hcktVNVZjVTVBMGJPMHRVYjM5M1g5N0NiOEhm?=
 =?utf-8?B?L2JBR3R5TE5oYndVbkNpRFpVYWdrK0hUU0gyRkQ0bXVBbzU2eEFKOE9jbEF2?=
 =?utf-8?B?dEVxYzJSRzNjZUlmRTZYL085S1BsRmdGSVBTVDZPbzV2SnEvSFFYQ29zWWJG?=
 =?utf-8?B?WHc0bXZPOCtPenJ3SlVwZ2k4U0pady9kcXdmcHZqYUJuMkcwVkMyS1JVcmo0?=
 =?utf-8?B?b2k5ZHpaSFRnNDhIYkZubXVrWVRpQitZRStOYnZRNWJiNU5pemJhT2I1djRQ?=
 =?utf-8?B?Q3JkVHZiZlpHSHJKa1VxNFlOb05qWXQzZTFJMVpmTlJlU2tRZktLNW5QRitJ?=
 =?utf-8?B?WlNhQmxzUlErSEZKcWRZNTJOc2hlc0cyWDJ0V2xsb2dRY1lMUk0xbEVlck85?=
 =?utf-8?B?aXc3Qm52bUg4dWp2WHZMUTRHQWxTVjNuU1N3MW9NL0Zka0NJV0EwV2hNQmFu?=
 =?utf-8?B?aTBMZXdUR0dLZ29ITUVRdWdHMDJHNG5lcURoYzBaNjI4dlhyUjE1OEZoNHR0?=
 =?utf-8?B?RTdKVkVBL09RdUNtbUxNeXIvVCtXZ0xVSU15ZmptTkZKaXFPMnE4MWdVaTRX?=
 =?utf-8?B?VDQxUFpXdVpOVmJVeXIzZlJTRmQ5OEQyTnZ1OW1LRysxMHd5MEQvSHdIN0c2?=
 =?utf-8?B?T3RxRW5vZXBCcGxTeWl6VFBsam1xRkZZeThxb05XcU95WW15aWxCWmVZS044?=
 =?utf-8?B?WHZFMnpDSGZ0QkpldGtpY0hab1ozSWYrMHUzNWhZU29makhvNWdmbGQ0b04x?=
 =?utf-8?B?eFZYZG9TMVJvY3R2N2tlNWRnQWl1NWNhcmczTjlOMk04QkpCRjFZNEw3a0p2?=
 =?utf-8?B?OHgvTEtvZ2VjaGFuTlRYUXY3dnVRd2tHcnY2eGJBK2RnVXFicEkrTjY2SjNo?=
 =?utf-8?B?RkE5UFE3ZThvUEZwMlhia0ZhTTBJYVpDbWFRdjZudWJWcUV3U1ZDdWdJbEtD?=
 =?utf-8?B?VFlvRHlFVWExaEZ3VXRHc0VjT3R2UHRMd2JGMitmUVJyQm1oMmgrUlRiS3dF?=
 =?utf-8?B?M1kvci91R21rZEsyUmFEdForYi92YzRBcDdoNzRVTytOMldNQWhuMGd6ZElD?=
 =?utf-8?B?SzhKMEZhYWJCcmZFVFRlMkc4aGNmSDhDUkVQYWV6YjdmcHJPcWd0RmNHdUE1?=
 =?utf-8?B?bjBWUCsyb21ORm1JZmlLTHl6WEFuS3pQRTJJVFMzUUpQOUIyUGUrZ1hidHp4?=
 =?utf-8?B?c0Z4N3V5ZXhzRGp0R1h6Wm9zNVRnbUFDblpXMjlLWjlaTDRaMzBjaFR6bG5Y?=
 =?utf-8?B?a3hFTWIxUUdubiswTkx1R1JMZnJkeUJBeVEwaURHd2Q5bERHQXBLMWR2OGZO?=
 =?utf-8?B?c0Zvc2luVnFib05sRW9UMW5jU3l4R1dBYTZ5b2w0WUUwWWJxeEtiRDVRR3gx?=
 =?utf-8?B?RXNScTdmN3pjbkpWTU00bnFFbFBSTTlOeW54TmxKcTlRcGVZVzFwbzZtOTB0?=
 =?utf-8?B?Q3FWeGtiTHFKUTRkdkJIK2NHd1h1cTJFTjN6Z3QwQ0FKU3lsVmNmZkkvU3hs?=
 =?utf-8?B?Sm9RUWNhVVNJa3BrcGJWMVd0UXJNUE9tTGR5cjJ6RnFrTzJDVEJZUTJtMk9S?=
 =?utf-8?Q?UTJx2SxIMjDTIOdAKhbAhAQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2349bc3-2f83-448a-088a-08d9fc31a1af
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 09:47:15.0053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jLcSPP4q1Jc8YjBdrn5UbQ7JvY4APbvkh1IGwK7PcACRT2fZgaa1c79do/y+qcLrjheQcyQDVvk0FbFvdTMCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4619
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   575115360652e9920cc56a028a286ebe9bf82694
commit: c664e2137a27680922d8aeb64fb10313416b254f can: etas_es58x: add support for the ETAS ES58X_FD CAN USB interfaces
date:   11 months ago
compiler: powerpc64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not be real problems)

    In file included from drivers/net/can/usb/etas_es58x/es58x_fd.c:
 >> drivers/net/can/usb/etas_es58x/es58x_fd.c:174:8: warning: Uninitialized variable: rx_event_msg [uninitvar]
     ret = es58x_check_msg_len(es58x_dev->dev, *rx_event_msg, msg_len);
           ^

vim +174 drivers/net/can/usb/etas_es58x/es58x_fd.c

c664e2137a2768 Vincent Mailhol 2021-04-10  165
c664e2137a2768 Vincent Mailhol 2021-04-10  166  static int es58x_fd_rx_event_msg(struct net_device *netdev,
c664e2137a2768 Vincent Mailhol 2021-04-10  167  				 const struct es58x_fd_urb_cmd *es58x_fd_urb_cmd)
c664e2137a2768 Vincent Mailhol 2021-04-10  168  {
c664e2137a2768 Vincent Mailhol 2021-04-10  169  	struct es58x_device *es58x_dev = es58x_priv(netdev)->es58x_dev;
c664e2137a2768 Vincent Mailhol 2021-04-10  170  	u16 msg_len = get_unaligned_le16(&es58x_fd_urb_cmd->msg_len);
c664e2137a2768 Vincent Mailhol 2021-04-10 @171  	const struct es58x_fd_rx_event_msg *rx_event_msg;
c664e2137a2768 Vincent Mailhol 2021-04-10  172  	int ret;
c664e2137a2768 Vincent Mailhol 2021-04-10  173
c664e2137a2768 Vincent Mailhol 2021-04-10 @174  	ret = es58x_check_msg_len(es58x_dev->dev, *rx_event_msg, msg_len);
c664e2137a2768 Vincent Mailhol 2021-04-10  175  	if (ret)
c664e2137a2768 Vincent Mailhol 2021-04-10  176  		return ret;
c664e2137a2768 Vincent Mailhol 2021-04-10  177
c664e2137a2768 Vincent Mailhol 2021-04-10  178  	rx_event_msg = &es58x_fd_urb_cmd->rx_event_msg;
c664e2137a2768 Vincent Mailhol 2021-04-10  179
c664e2137a2768 Vincent Mailhol 2021-04-10  180  	return es58x_rx_err_msg(netdev, rx_event_msg->error_code,
c664e2137a2768 Vincent Mailhol 2021-04-10  181  				rx_event_msg->event_code,
c664e2137a2768 Vincent Mailhol 2021-04-10  182  				get_unaligned_le64(&rx_event_msg->timestamp));
c664e2137a2768 Vincent Mailhol 2021-04-10  183  }
c664e2137a2768 Vincent Mailhol 2021-04-10  184

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
