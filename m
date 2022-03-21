Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E8A4E23DE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245584AbiCUKBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiCUKBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:01:51 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EA660F9;
        Mon, 21 Mar 2022 03:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1647856824;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=4RckOyHuQ5kYI0KTpTlxEdTuSeWl8kDZa4B0qCmjOyw=;
  b=Lo1gg80pLusbju6jdA6LvDPahNROEAnJcgd/PyVdDOySTWhAZ0rS7DgV
   PwmDXbQM2dkPT4Hi+wnXaQnYg+CezyTq+CSXQNaZhX2V8OphRkhlKAn/K
   rZVek8F7K2Pwv9TKPud7sSWZwBUzK5DTH1ho8ZwgT7Gf/q1VGUAP9Wm/9
   I=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
X-SBRS: 5.1
X-MesageID: 66745199
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:A0pLa6nPgzHnKsQaygorzzro5gwGJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIaD2nSbv7YN2T8f9snOY2/9EwCvcPRnIBrSFBo/npnRCMWpZLJC+rCIxarNUt+DCFioGGLT
 Sk6QoOdRCzhZiaE/n9BCpC48T8kk/vgqoPUUIYoAAgoLeNfYHpn2EoLd9IR2NYy24DiWVrV4
 LsenuWEULOb828sWo4rw/rrRCNH5JwebxtB4zTSzdgS1LPvvyF94KA3fMldHFOhKmVgJcaoR
 v6r8V2M1jixEyHBqD+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRa1hIg+ZzihxrhMJ
 NtxWZOYGRclNJHtksshTzpTTCdAOLJcpIDKCC3q2SCT5xWun3rExvxvCAc9PJEC+/YxCmZLn
 RAaAGlTNFbZ3bvwme/lDLk37iggBJCD0Ic3oHZvwCufFf87aZvCX7/L9ZlT2zJYasVmQ6iBO
 5dAOGsHgBLoXS8VFFkFCosHjMjzuWTdSC1qolDFqv9ii4TU5FMoi+W8WDbPQfSJSN9Tk0Ldp
 GvA/nj+GAoyKtOS03yG/2iqi+uJmjn0MKoWFbul5rtpjUeVy2g7FhIbTx24rOO/h0r4XMhQQ
 2QQ/jQrhawz71CwCN38WQCo5nKJoHY0X9tWDv1/4gWKwan8/QmUHC4HQyRHZdhgs9U5LRQh0
 VuImZXoQz9utrK9RneU97PSpjS3UQAcPWUFaAcHQBED7t2lrIJbpgLCSJNvHbC4ivXxGCrs2
 HaaoS4mnbIRgMUXkaKh8jj6bymE/8aTCFRvv0OOAzzjvlgRiJOZi5KAuUjX58phJqmlUnqK4
 346nteEsN8DJMTY/MCSe9klELas7veDFTTTh19zApUsnwiQF26fkZN4u28nehowWioQUXqwO
 RKI51sNjHNGFCHyBZKbdb5dHCjDIULIMd3+Hs7ZYdNVCnSaXF/WpXo+DaJ8Mo2EraTNrU3dE
 crAGSpPJSxDYUiC8NZRb71BuYLHPghkmQvuqWnTlnxLK4a2an+PUqsiO1CTdO0/567siFyLr
 4kPbpPTkkUGC7yWjszrHWk7dw1iEJTGLcqu95w/mhCrfGKK513N+9eOmOh8KuSJboxel/vS/
 2HVZ6Or4AGXuJEzEi3TMioLQOq2Bf5X9CtnVQRxbQfA8yVyOu6HsfZAH6bbiJF6rYSPO9YvF
 KJbEyhBa9wSIgn6F8M1NsCs8tY9KEz12Wpj/UONOVACQnKpfCSQkvfMdQrz7igeSC2xsMo1u
 bq70Q3HB5EEQmxf4Az+MppDE3vZUaAhpd9P
IronPort-HdrOrdr: A9a23:vQWcVaPv/ZwJfcBcTyP155DYdb4zR+YMi2TDiHofdfUFSKClfp
 6V8cjztSWUtN4QMEtQ/uxoHJPwO080kqQFnLX5XI3SJzUO3VHHEGgM1/qB/9SNIVyaygcZ79
 YdT0EcMqyAMbEZt7eC3ODQKb9Jq7PmgcOVbKXlvg9QpGlRGt9dBmxCe2Cm+yNNNW177c1TLu
 vi2iMLnUvpRV0nKuCAQlUVVenKoNPG0LrgfB49HhYirC2Dlymh5rLWGwWRmk52aUIE/Z4StU
 z+1yDp7KSqtP+2jjfaym/o9pxT3P/s0MFKCsCggtUcbh/slgGrToJ8XKDqhkF/nMifrHIR1P
 XcqRYpOMp+r1vXY2GOuBPonzLt1T4/gkWSvmOwsD/Gm4jUVTg6A81OicZyaR3C8Xctu9l6ze
 Ziw3+Zn4A/N2KOoA3No/zzEz16nEu9pnQv1cQJiWZEbIcYYLhN6aQC4UJuFosaFi6S0vFqLA
 BXNrCc2B9qSyLbU5iA1VMfg+BEH05DUytue3Jy9PB8iFNt7TJEJ0hx/r1qop5PzuN5d3B+3Z
 W2Dk1ZrsA/ciYoV9MOOA4ge7rANoWfe2OEDIqtSW6XYZ3vfUi976LK3A==
X-IronPort-AV: E=Sophos;i="5.90,198,1643691600"; 
   d="scan'208";a="66745199"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FH0GUeUe9+XOTHqYtAraBj4C2XnrHeoM96AcgSsK6b1nc7vdtInAi9j/B3XqkqFITd1+oXJFfAlPpWPTEqNAh+06GcJo5wEQB6KCxdAcoCtzcahmTM7lByxJwjcqOmG74ANE9rFI70JW84OZ+Ypp9bVuiBM/oZarVsu1VP1uacPKPEztsFwuEattbPIjEKVdJPgY+XNmBlUwo7ebtKvbOwfzWU1LypnvxDWTT0KUWoY6uu7z5NOY5dX/rd5QBgQBYDJXoOJ2pAmFyP2A7EZHGxpBnRd4L+9I+cvnrcvYzjCvyzOSVJ+CrYCZ1JxoThKBcQJsP9ZOVDaJIHT0u552Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJxLXOd/g+NcgzFBMKk/6O/8OuPEssPXeeYfnKDPtG0=;
 b=A50FAf01qR7bF9Glx54iJv603uLfyzarwcGG7uNUmVlxIhelTJUzuRsK51wYIH8ZOWuV/CTKH5V4t8Jc/YHEozMFC7D31/2vt2eK7HZxYss+ha4HrIPhibc59Om8xtVhte8bLo8wDptFDzYXrMFjN6vOWbpXU/3R+FvH22TDA61EREtUaat0ZFW87QARNaHHrAyJTN5G8MWyoCeMLczVWEK6b9KQlIyFpdJFwHyoYfgxp4ARUmtV4yZDFZ03UfBgJSTphWCYb5yn1pIeI6gJrqWe1mzitKFfNFQ7aRk+HsTplId7ww+KD+3bql750poKtKHLkY13rgrA2uElElFQmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJxLXOd/g+NcgzFBMKk/6O/8OuPEssPXeeYfnKDPtG0=;
 b=hRlQ2QNydZbs7MZMO1KvtkrBRuRkLZwBUG42Ek518GlXXVSXk9JCG38xpjCQ7vE6jramEwoBU8J3HQusSfaqVqER5N8dAFW1eWsVrb2GU9mMpRDLlENrDtGn2a19wC6NTe2unGeWHN4T1WhIk1rA6k12Qe9IewvCcUyZp3upkl8=
Date:   Mon, 21 Mar 2022 11:00:13 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Colin Ian King <colin.i.king@gmail.com>
CC:     Jens Axboe <axboe@kernel.dk>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
Subject: Re: [PATCH] xen-blkback: remove redundant assignment to variable i
Message-ID: <YjhMre8vckI1HbSS@Air-de-Roger>
References: <20220317234646.78158-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220317234646.78158-1-colin.i.king@gmail.com>
X-ClientProxiedBy: LO2P265CA0241.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::13) To DS7PR03MB5608.namprd03.prod.outlook.com
 (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 889f5f94-f5a8-48a9-f05d-08da0b219ab6
X-MS-TrafficTypeDiagnostic: PH7PR03MB6944:EE_
X-Microsoft-Antispam-PRVS: <PH7PR03MB6944166296D4E2C6802A04878F169@PH7PR03MB6944.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50Mk5dI1AbaE+zveTAmqMcD0J+N9zbjq1kfTbL/bTjpVrYDLFXnAPg19bmMHVyDxes7bnAyfoBKE3YmMO2tFNznIPE0JfPa643m1fxYaVwq2xgD4WfhEL4Lg0L2j9NZL3EfkbKJ01KLdKWcPqtjYxmip5RRFku1HilWblK14SIImo9Cu9sYUPJHLTHc6ay62iEiAxcibnIhBL9ly9BDYgPdJFAFeMxALad0rq7i6LxKnlgBl7QPP+U+XhflYwNn3vFHUGz5qkwto3qHQrg0hupd/wfZyufmcZAoMkWbTJaaLTf+NxMXzpHSZKhG8yMAEG6fdqqqrbT9zHWFsvH9abyHuoHB8JIwOtIxDJ6fAMgHQWzBWoAu5c6SB1jWq5haYcsh0cmfNKN61TNhdOI8Vlz+wYGy6fZlM05SnT6lUZ/5GEbEnf8EFe6ZHvW+rSgtdw50z8j1+BOQojAMWIwYpFcfaV6r5C8QgpJfRMuYy+qyS0g8iy6Spy9qSQZ/38Ap2h4RSofGXLzc/bkC/rW14baDdAXCe9gPOohCZzkcski2/9zSvziJsvAXqg0WFOA8byPpm02Xoh/9qiU9kML9aBSXyrBKtDAm1JkYVL41NJ0odaiFzRhoII1Iw7rKCip1gQ7BENc/4HhRoSXqxsGmBpV0BqkaAqS21m3ZOX7ErtO1OVgERI8VSJBJnmPSoQ5QUS4JizGNYQmu7u1faxEKJNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5608.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(2906002)(9686003)(6512007)(6666004)(33716001)(86362001)(83380400001)(66946007)(66556008)(8936002)(66476007)(85182001)(4326008)(508600001)(8676002)(6506007)(26005)(82960400001)(186003)(6916009)(4744005)(5660300002)(316002)(6486002)(38100700002)(129723003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGMvakdRM2dwR1ZGQUk0SVIwclhVdFpwaTRVQ0lhWUMxbDFabEYxOHcxa0tI?=
 =?utf-8?B?OTg4SEpwOC9meDNPcHVFYWVyVFEyZ0Q4eXFSSk9MZnVYMzNNOTRIeWtVMEpF?=
 =?utf-8?B?UERrWnAyZkYyVnRCRWVsMzF6bG9YU0NhdzR4Q3RvSXpDa21LcDZLTzRQVTRC?=
 =?utf-8?B?cFF2cCtqMDlLSXVoR2pDSUErVGo2aDdZRlJyNlhBM1BRS3FoWUlnR1lJMGpG?=
 =?utf-8?B?YjZidFRSV1BlN1pkVitkVldrUGhDaEplMkdHem9Cbk5ZSk41WjNCOXN3MCti?=
 =?utf-8?B?UEF1MDhRK1hBdkJnRWlTdy94ZVZZWjZrMUZkTElyd1QvR085aFhZVFdkdlpL?=
 =?utf-8?B?NFJFdnA3NE5Gazk4M253Sldrb0JlTXBQYTNHd1hRVndlUEF5bllNMmtLZllQ?=
 =?utf-8?B?U1o1YjFLUHNCNEdsQ1BNS2UzRlIwZTBYN3prNGZoM2xmU202d1NhUUxQby8w?=
 =?utf-8?B?ZG1BMVRqK1hlTDVRTjZQSzF1UzI5RGFjWXdFQWJadC9UYzBEalJpdjFGYUNZ?=
 =?utf-8?B?bWVEQ0N1bGxzNloxMVNIbmdCdmp4NmUyUDhQMVlYOFNBUmxkT1hPRjdPcGxk?=
 =?utf-8?B?d3VlY2ppS01GT2RkMEVQYWpTQnZETTRKMmtYemNwMWx3dVpaQXozcHg4aWdO?=
 =?utf-8?B?ekRxTkQxblUzT2kwMG9KbnhNK2h2TXFGWmNLN2Z4NlJDcDhhTVlkbTVGaDU3?=
 =?utf-8?B?UEwvaHlFTEp3d2tHR1hIZklEeTdlUDNIbHVET3gwRXp0YzZxNXNiM0FmL3Rt?=
 =?utf-8?B?VElIMlF3dGw3ZjM4Rzg1K0JsbU4vUzhMWTA3T0RSR25HYzNtYld3YWVYU2gz?=
 =?utf-8?B?QnBNdlo3Nk52RzBNQW10L0ltY3dJL0h2NUR1UTdkT0pUKy9WN1V1SGh3eGlJ?=
 =?utf-8?B?TVorT2o4eDZkdFJ2MGNSS0czVlBZek5sRFVTOEVJUDZVUWY5M0JLam5PSTB6?=
 =?utf-8?B?ZWI5N25IRzBndE5rY2ZJK2pQbm5YWVJTU1Y4S240N0hKanc5RWV0YlJZc296?=
 =?utf-8?B?cGpNcWxyNXJNRTQvSktudlRlVzl0ZlozaE83ZDB1ZlNhZ3dUQXJzamo2UDYz?=
 =?utf-8?B?VHUyY1BIbnQwMzYvbnZpb0FqLzl2UFZaQ0tkN1dQWVFDeXRLcXAzM3NleCt1?=
 =?utf-8?B?aGpXcDZrWG1UUy9WSGNLVUZZNmpsZVFkdUFNU2tGV2s0MUlyY050bThCNVJY?=
 =?utf-8?B?S1lQVC9wcllJdDVKSStKMHZwWWQzaWVNbS84MmRkelFSUEtCdmZrUm1kU2F5?=
 =?utf-8?B?N1FQMHJMQWhRcWV2RThGYXVRRWRpeFdMZXVYNW40bVpOalVTODRmRjBNYU02?=
 =?utf-8?B?am85SGY2ZUFCQU93MkZOZ213NVNBWS93ckpOL2xIUkpOSzdGSTlYVFd3OFI3?=
 =?utf-8?B?cEZVNUlwbVhnRmw1QzI5VGRkbXAwVE1iSjlLVVREOE5EbHJ6cHBkcVhjcEVZ?=
 =?utf-8?B?T1NjbTdKK0JMaGZnOWdkUjRjSDRJQW16MGg0cTNiN2I2RVVkdHZFQ3NqV1RV?=
 =?utf-8?B?QXQ2dGp0WlJWSmZiaFREMFNRWWRFdE8vYll3MUx1NHg1OEZjUm5mZ3lEZFlt?=
 =?utf-8?B?c0FCdE9Yb3NYOFhqR251VXovOFpoeDM2S0ZTTUFjVVFlaHNMU0JVay9LSE8z?=
 =?utf-8?B?d2FJTThtYVM0YlUxVnV4SENZbmk3UWt1YnZGUXpOdzkyWnEyMGZoQ210bmY5?=
 =?utf-8?B?cDQ5Z3JrMmRrOHNObVBUc0hKcVpwdlBrc0JKeUZiVjJ5MXVDaHFRd0dncmtw?=
 =?utf-8?B?ZStJZGFBQURXcHNFZHQyaEhnbTF6WUY0MHdLRnlCYWcyblJXT1lUc1oybW1j?=
 =?utf-8?B?T1VmcXpvTjNRUXV4ajFZTW9PU3ZaOHVHVWhtS1RJallTcFhSelo1aklsVUNO?=
 =?utf-8?B?QmxPOFJWY0xDcnNFNFpITURTamJLbUZvTE5ZTE5wMW43TDE5TXdaMFBQWTla?=
 =?utf-8?B?OVFuRzJQOHBUNVlLSTRVNFJIcGxycXZPK21VOURUTUVNeW9UdnpBMDJra0Nk?=
 =?utf-8?B?aGdHalI4dXdRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 889f5f94-f5a8-48a9-f05d-08da0b219ab6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 10:00:18.4946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSxd25QMo8d1nkDYATJGnZ8HAwfUk1uR9jct47LiURPY7APTQhZEWmnH0+gTsdkiPbgzEUQb9E+hBeBygge2Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6944
X-OriginatorOrg: citrix.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 11:46:46PM +0000, Colin Ian King wrote:
> Variable i is being assigned a value that is never read, it is being
> re-assigned later in a for-loop. The assignment is redundant and can
> be removed.
> 
> Cleans up clang scan build warning:
> drivers/block/xen-blkback/blkback.c:934:14: warning: Although the value
> stored to 'i' is used in the enclosing expression, the value is never
> actually read from 'i' [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.
