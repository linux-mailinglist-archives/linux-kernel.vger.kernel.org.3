Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00995495180
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376663AbiATPc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:32:58 -0500
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:62225 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346385AbiATPc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:32:56 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Jan 2022 10:32:56 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1642692776;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ihXuRc9VccmNFcUBgjiAWM48zQvEbC7wypVXEHiqcUU=;
  b=XImyTMtzDseNmmqlhVN37tMVq/x+A/eUEs5n6RgWXZoOkRA02xYlNBJU
   qRtEIyY6JoqSTBBqxmQ2/2bVs0M49I8cUIwertcQPLnqyuZOwfq6LOfKe
   ncHJXm+cyOw1sVTjHhhZTsZWAMDzPUeh1KEOuMgIbyalxyyQASx/ySp3x
   s=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: /cWfTzEsOqeAX9iBXetNjKc9COPhwo1m8lEtbS8GkATo+2MhEW0i6Nr6XgiqK7ahTx2afo4UoX
 fehiE8/KP8FxLc6xiJaJOdbyjc9zYMv2poxX0ABzftx3sNCX5nCtvIiorsppWHkMi1A7Qr26/2
 RlTZxPiH0W51rfzb0ybTD2kmFhFVuxPcxg0xq5vXGN4P4Dj4ioGJwj8HVCkTvFWIp4jJu0f4Zr
 Ds/H0gm4lBCTVrYVYJewBn1nNVnxVZaEfr4mqTdiCeuQ/TcHF0L8EK4u7FdQIHiueSI8ecfXNf
 jgD1UbS/2WNRseQda2jx5tTz
X-SBRS: 5.2
X-MesageID: 64562825
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:WmIt7a7O1l8wGcZXktRfvgxRtP7AchMFZxGqfqrLsTDasY5as4F+v
 jYYW2uEOv+CYmOjKI0jPoTgpE9Xu8TWxtAwSwY4/ikwHi5G8cbLO4+Ufxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuV3zyIQUBUjclkfJKlYAL/En03FV8MpBsJ00o5wbZg2NYw27BVPivW0
 T/Mi5yHULOa82Yc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pGTU2FFFPqQ5E8IwKPb
 72rIIdVXI/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8CbP2lS2Pc0MC9qZzu1c99Z2
 o5hiKa2dBUSZoqSssYkFBJRLCR3IvgTkFPHCSDXXc27ykTHdz3nwul0DVFwNoodkgp1KTgQr
 7pCcmlLN03dwbLtqF64YrAEasALNs7kMZlZonh95TrYEewnUdbIRKCiCdpwgmtt2JoeR6u2i
 8wxch5TRg/CYRp0A04KWJsTwfaYtmvffGgNwL6SjfVuuDWCpOBr65DpMdzIapmJSN9Tk0Kwu
 G3L5SL6DwscOdjZziCKmk9AnceWw3m9AthLUuTlqLg62zV/21D/FjUEDneGm/+EmHXmfIx1C
 XVT8SMRqKEtoRnDosbGYzW0p3uNvxg5UtVWEvEn5Azl9pc48zp1FUBfEGcfNYVOWNseAGVzi
 wTXx4+B6SlH6eXNERqgGqGoQSRe0MT/BUsLfmc6QAQM+LEPS6lj30uUHr6P/ENY5+AZ+A0cI
 RjW/UDSZJ1J1KbnMplXG3id31pAQbCTH2YICv3/BD7N0++ATNfNi3aUwVba9+1cC42SU0OMu
 nMJ8+DHsrxUU8jSxHDTHLxddF1M2xpjGGeA6bKIN8J5nwlBBlb5JdwAiN2ADBoB3jk4lc/BP
 xaI5FI5CG57N3q2d65nC79d+OxxpZUM4e/ND6iOBvIXO8AZXFbeoElGOBDMt0iwzhlEufxva
 P+zLJf3ZV5HWPsP8dZDb7pHuVPd7npglTq7qFGS50nP7Idyk1bMGe5aawPfN75ghE5GyS2Mm
 +ti2wKx40w3eMX1YzXN8J5VKlYPLHMhAovxpdARfemGSjeK0kl9YxMI6b9+KYFjgYpPkeLEo
 iO0VkNCkQKtjnzbMwSaLHtkbeq3D5p4qHs6Ow0qPEqphCd/Mdr+sv9HestlZ6Qj+cxi0eVwE
 6sPdfKfD6kdUT/A4TkcM8Xw9dQwaBSxiAuSFCO5ezxjLYV4TgnE94a8LAvi/SUDFAStss46r
 +Hy3w/XW8NbFQ9jENzXeLSkyFbo5SoRn+d7Xk3pJNhPeRqzrNg2enKp1vJuepMCMxTOwDeex
 j26OxZAqLmfuZIx/fnImbuA89WjHdxhExcIBGLc97u3a3XXpzLx3Y9aXe+UVjnBT2eoqr66b
 OBYwvygYv0KmFFG79h1H7pxlP9s4tLuo/lRzxh+HWWNZFOuU+syLn6D1MhJl6tM2r4G5lfmB
 hPRooFXaeeTJcfoMF8NPw50PO2M2MYdliTW8flocl7x4zV6/ebfXEhfV/VWZPex8Feh3FsZ/
 Noc
IronPort-HdrOrdr: A9a23:gcMNaahWVz/b4yyO6QbRg01czHBQX0J13DAbv31ZSRFFG/FwyP
 rAoB1L73PJYWgqNU3I+ergBEGBKUmskaKdhrNhQYtKPTOWxVdASbsN0WKM+UyHJ8STzJ8+6U
 4kSdkENDSSNykKsS+Z2njALz9I+rDum8rJ9ITjJjVWPHtXgslbnnlE422gYypLrWd9dP8E/M
 323Ls5m9PsQwVdUu2LQl0+G8TTrdzCk5zrJTYAGh4c8QGLyRel8qTzHRS01goXF2on+8ZuzU
 H11yjCoomzufCyzRHRk0fV8pRtgdPkjv9OHtaFhMQ5IijlziyoeINicbufuy1dmpDk1H8a1P
 335zswNcV67H3cOkmzvBvWwgHllA0j7nfzoGXo90fLkIjcfnYXGsBBjYVWfl/y8Ew7puxx16
 pNwiawq4dXJQmoplWy2/H4EzVR0makq3srluAey1ZFV5EFVbNXpYsDuGtIDZY7Gj7g4oxPKp
 ggMCjl3ocXTbqmVQGbgoE2q+bcHEjbXy32DnTqg/blkgS/xxtCvg4lLM92pAZ2yHtycegB2w
 3+CNUaqFh5dL5jUUtMPpZwfSKJMB2+ffu1ChPrHb3GLtBPB5ufke++3F0KjNvaDaDgiqFC36
 j8bA==
X-IronPort-AV: E=Sophos;i="5.88,302,1635220800"; 
   d="scan'208";a="64562825"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOQKt3PL7R2xcO1Xoa7FSrbrFAuN6fSaVVv9s3Qm0yuY5n4uxuopgiwTXbxIlPvY3LeUMGDfr8QtKDgm5k4Pv3ahiIDla3ATLUdUrYusZ1/herxDIZgMRb8N0Om4KLwhfKZ2TpsHb36+JaV7+eb9UgwGeekRzfTcu7OABEHc3iUjZhjAjL5btFgLYslph50jynDTa/pJBnxbSTPMXk6DBYtae6gSHt8s4yt0LF3PjIK5pqoxBLe8sfGYSaRdWj88c/wbaqlXNOPcN+LZxfbraiZwTzxIJMig7H76hx9JQo9eOccqTEZfsc63Bs0Sq/Xx+oTfYwDyU0PtCD0nb11SrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oIfLIGdwZNZYOUj4IE0DMdzfoOGTvBy/VKEYbhrVro=;
 b=XvRkZs14a+c4e3/o8eO5rTzNmzJOqZZXpVGVbMAqhuxMNH4gtZPC36W2p/13wMX21wRT4fX/oTdxMA0cpCy89hd4+sYIS49BBm1VjnJsfEVVUs0mN+8Whtg53QorAxUW3Xx7s2fkSCC5G1shx0ouDDp6M0xuM5j1CDhRJkg+kDLHI56e+cENGHVGqDQPYxujrtWeI6XHknryNk1If45f6TUrvUOecdYW3uiaO+ThczeXeQre4kh+gz44/nBCya/bc82u2e7Xr206Y/dajwWI9lxqOPgpGK6Wo6rQ+rJ7R5RjyVNkLgzsRLwbYBvIRG6dBzEvxHusMqlNoPhThGPH+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oIfLIGdwZNZYOUj4IE0DMdzfoOGTvBy/VKEYbhrVro=;
 b=daTkutt2rUJRSgYPntll1YVdaDA8e8fUUX9k9k1P3ryx40S5v8q39iyAhQzPV1wlGyWETqZrQr0hmh5Q6Qm42l46QnNQVjxknnOHW5AaGCZT+Gx2ZaEUsAhRYm2Jaknd+OvCGkI1t+nrVY7ur1ErTDBJe12NizVabJt2rYKsHng=
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>
Subject: [PATCH 0/2] xen/x86: use extended destination mode if available
Date:   Thu, 20 Jan 2022 16:25:25 +0100
Message-ID: <20220120152527.7524-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::14) To DS7PR03MB5608.namprd03.prod.outlook.com
 (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0ed3ef3-b23c-423d-f232-08d9dc291e06
X-MS-TrafficTypeDiagnostic: SA0PR03MB5468:EE_
X-Microsoft-Antispam-PRVS: <SA0PR03MB5468405B1C484206816080CF8F5A9@SA0PR03MB5468.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9JwWGASmmrHN42XEzDw5cViaY+JpueMOFiZRxyerAZHY/GC2zm1hsr0RCpFwkfckL5V5OmHC70+SgQswdCc9+KFC7hjTKith2RWRhpy9Y4pBYabO/lGc4RTyZUNLOv73NfsGMaDEiwHvbUvWLm5BbPA2mZib7NFqXtNbDyYPJRYL87tuKxxoKoLjJkMJ+1qyWG3XbTNsPINFDvC3Ul0Lf/R5QQFV01ukzAk81P6LsMdI7IZP0+qEM4LNSW0cQcFy7YFOT3BXDC6WiTJLaTfwyUtUcSTXKqXHFJwyT4ftv19PuqPNOvdE1qbvFMTUOF6wjB0J0PW9BIdLaRpQ6vMNH8Otl5vu6kDNYqskvkWIxf4qg6RcNl9EKYnsDvJZtarRhhix0KBuAu8jxYYg0ffqLa579JTbMXx89A4gchwsbnDtmPoQa/lHzPjnrZzNG7XDGaekc/4nK5ONWZBKkvprXuHzr+lOkVszy/EEqUep145CCRjPBaKBl8J5wdSXTdOh9tTM/g5iYNZJSfEvSloze93D9ck61y2cZXTL3cNBSeD9K6U2F46+RWOn9Sbjj9l7gXJfk7hEP2NiCJQ9+Qdb8Wb1jEOpl0XavYcyI7yMXkZO2o0ucE+1JhISuhfUm2lydPSOhzcpbLDQD79x5R8CYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5608.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(6512007)(6486002)(6666004)(82960400001)(66476007)(66556008)(6916009)(316002)(8936002)(36756003)(66946007)(508600001)(83380400001)(5660300002)(186003)(38100700002)(26005)(6506007)(107886003)(2616005)(2906002)(1076003)(4744005)(4326008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHVpcUptWGU3cXJIcGN0NkZIRjRYMk9CRlE5VDA3OXJGTVNwd0xSVmU5TFRG?=
 =?utf-8?B?bk1vd1BVM0ZoUWxTT29ydzNoUHVOTzJPNDg2K3Z3Rno1SUZQdlBsWWVRYTVx?=
 =?utf-8?B?YnQzTlFXZkxmZVBVUml5Mkgza2k3a0R4R3BmMVgvQ3dZd3hsU25zZm5ZY3JP?=
 =?utf-8?B?VnBobmQzQ3RoNnhOdmJBZ2tuWldIcFprV1hZaGJDT3hHZ0FMaFNTTlM4OW44?=
 =?utf-8?B?bFJVc3NDL29LNTR3bUhPU3pncjNmNXFHdlNoTHZxaHRseHF5aUZ5cjJ1VmJr?=
 =?utf-8?B?ZEFFQ1oyM1BxekI4OVVCTTBMYVNQMGdoLytRek1SSWl0SmNsZHBldjM0aFAz?=
 =?utf-8?B?MnBnd2FBR3RCS3EwUVZkUGRHdXltckdBWUVaUHFja1pkeFE5a2p6T1lHM09H?=
 =?utf-8?B?aDZGYzE0K2ZMUVhlZmtnaGhDSDZPU2ovMGNGNTVCd2VLTGFnQ1hTbEVZR0Fj?=
 =?utf-8?B?S0hWVTdsVXU4L3VWMDJKZHJ4elhXMUpzeENkTzBOUXdrUkJHVEx1NEtVUE93?=
 =?utf-8?B?OGN5QVR4Zjc4OXY5am9NNXc0aG84bDdoRE1tWElQZVZXY25WYlRsNElseWw0?=
 =?utf-8?B?TGRhWTY1aDlqR2FaWEF6MEFzZlZmcFBHSzBvVC9HdG9mUzRkZ29uM0Eyd0tP?=
 =?utf-8?B?MkRYS0dsSDUxemdlUzJYVytJUW9iUHVSMnhodXRYZElVdVpSUG85dkozdDFj?=
 =?utf-8?B?OE4wdlBCVmhzSnZxNWhoM0FMaVdLU2l5SVh0UFk5Yjh6Y0Ixblc2Z2kzd3Qy?=
 =?utf-8?B?c0tzR3V0WFdHKzA0V3V3TU9GRVNzWEpyTFp6US9XV0ZQTE8zZlJycGxaL2xP?=
 =?utf-8?B?aHJaTTVBSERXM2dpMjJqZEUyMkQ2Mm55bHpGS0RCQnpOYU1vOS9LMVJUL2VI?=
 =?utf-8?B?L280cHN3ZFJPalZ2L2ZJYWhIU3NxcTNsWnA2MjhDME50K250R2NOblY0Rml4?=
 =?utf-8?B?bEI3SkVkeXhWQjBpaFB3OGd4a3VKQlB5ejhjR3BGUDRGQmV4YzFrUkR0N2hx?=
 =?utf-8?B?VllQMTdKWnBmV05nQ2F4Z2pCaVZQOTVyWENPSzJtNS92eDViTExHeWExN2pF?=
 =?utf-8?B?MUlQZHNhL2M1M0NpYk0vVnVIaXNmbElOTXgyY2w2YXFyU2FOMFdtcGx3RDgr?=
 =?utf-8?B?TjVnbGgwZkp2L2o4ZktyamZLOXZKRGFsbFFpTFhPa3YxZENmMnpXQldXS1RE?=
 =?utf-8?B?eHl0NkI4dHUxalJBSDJDeU1RaXJLOE53ZWM3aXREVHVvYXNxWi9vYXVsdHll?=
 =?utf-8?B?bW96OWEzVEVDWUtINWhLREdTVWw1TFhpMHVYVVZidXp0S3RHS1pCY3k0T3lP?=
 =?utf-8?B?Y0lKNGo0RUNxdzg5eHpnT3NMWmtwbWQwOXExNHJ5d3lBWHIrUWEwTHU4dFdP?=
 =?utf-8?B?N3NBZWpBMWVNclQ1RXltdnFBMFlZUXBmcXNTTzZtOHhQWHF3WkZSWmNhdzdT?=
 =?utf-8?B?djlaL1BrYmNBSndicmJVMkZYdi9ITElDc0FPbjJJMnhGVFVEazZsZFBnbnho?=
 =?utf-8?B?RnhjbVpFQzdZbGpEcDFxMWNDdzVGb3hFeCt0enc5VUNvS2lBTStuSEtHdFpH?=
 =?utf-8?B?WkpnQzd2QzQreEVvR2dKUnBBRnZmdXAvK0YwcnFaajlVUmRid3l3TXRGbXh5?=
 =?utf-8?B?aklrNzUrZXpIK2Znekc1dWdnVThXNHBMbEpSaHRqQWVKNEEzWXhhVHZaUUpB?=
 =?utf-8?B?RkNBb1dLNG9WcXB1Q2VhSk5rZUxCUWp3a3lpaURocGZhbDk5QmhGQkNYSkRq?=
 =?utf-8?B?bFk5dklSb0tGWlJIT0l3SlIreEFuOGZCdUdvUHAxbTR5Q21ER2JxaVNYeDFM?=
 =?utf-8?B?RUoyRFJ6Y3NpclVnS0VmK2FOemcrc2gvZTFqSDBNeGhOYURPMzJ6VXdVTlF1?=
 =?utf-8?B?cmFaWm1EYlJ3alRReVY1YndtYko3eFNVejdHYjhQUVVJZUlISFE0TlZldlZi?=
 =?utf-8?B?T3Foc3FlNzljSzdoaTZxbXd3UStTbGJKazdRcldkbzRPUU1wZVpJNlRYNUla?=
 =?utf-8?B?OEVvVW5OdVFDTVBLMk5hbERNR28yYnFHMTBwMDFMbFgxTzlXWGFmbmJwWmdh?=
 =?utf-8?B?TExGZEtBVHlBdUIxbDF1cnZlZXZJMHlmRndNc3YxRUVMcE9xR1dzb2dkM1JW?=
 =?utf-8?B?V1BQMU54Z1VyemFEWGl5a1diNElmNSsrbnJETVlYVW5mSVZ2OWVsQlgrMnQ2?=
 =?utf-8?Q?9Oqa8bmUpNPnvcZBIUWZqdk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ed3ef3-b23c-423d-f232-08d9dc291e06
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 15:25:40.6270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1g/K5DYfVXde1/qOPx8iJzz6suTTbN1qQOXQRf4CR61OyD75jxO7D7TyxW207ew2GsC2DlZrk8v+nJDkVq7IWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5468
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Following two patches enable the usage of the extended destination ID if
supported by Xen. This is the same feature already supported by QEMU/KVM
and HyperV.

First patch can probably go in regardless of whether Xen ends up
implementing the extended destination ID, there's no reason to prevent a
VM from using x2APIC mode.

Thanks, Roger.

Roger Pau Monne (2):
  xen/x2apic: enable x2apic mode when supported
  xen/x86: detect support for extended destination ID

 arch/x86/include/asm/xen/cpuid.h | 7 +++++++
 arch/x86/xen/enlighten_hvm.c     | 9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.34.1

