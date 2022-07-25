Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A4957FD07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiGYKIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiGYKIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:08:50 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172EB113D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1658743729;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kqItF+M2OU5sj85TVLt33ajlOHQoYByO3WX7XoCmzRM=;
  b=eIeHh9o/iJuTKqvfofjOs1SF4S+EY/zg0+R0z+fZwJqAvVgp42f+pv9D
   vs69A2/6Nd9/iLGo+G5T+YCaEaJBr+GifCUlZZp5mQ66nrIJNzdaJuZ45
   Mb56ghOrlcdo6boZowPDb2xZWvqsevZpr05WsZTYoWWoX+3p87hpuKc7i
   8=;
X-IronPort-RemoteIP: 104.47.56.172
X-IronPort-MID: 76538133
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: =?us-ascii?q?A9a23=3A/8UdA623NOLNzwVcK/bDix16xcyv+3FdZeh4A?=
 =?us-ascii?q?8V8DSJ0REvO9WDO3PKurZDyZGxZPOn4GStR26+fTktD0PdbNrls31Zn9NXzy?=
 =?us-ascii?q?/QiOsJtSRd74WGFBWcTQ9A+bv0Cw37+Nnr9lfD/IFbu2NC/edcIEQpxJrffT?=
 =?us-ascii?q?oxuii9dqj0tfQ3QX1JvQptL27O95WOUI6kmzki68iPiwla1DT52pSSzN1PL6?=
 =?us-ascii?q?FFhohbynfVNOdSMN3Rn+vSxX9SMqMf36cBsfa7lM242Ftacw4mOxNPGSGODY?=
 =?us-ascii?q?97vpCB03QiHsAdt4Z+JEtwTsHtXPLnk2XLS7h6VCT6UggYk+kNwSuyZ/AmU3?=
 =?us-ascii?q?s9wE8MwZMI1ET8XimFuMle/Qdw66lEz4I6e/Y7K7NULn7MRvZ2x4641TGfRM?=
 =?us-ascii?q?Qoy5jPiQO/TcDv57AGbRO53/0ImuzALNqhu0TkuQ8K/Gkiy9FuETsTR7/y85?=
 =?us-ascii?q?IVJn9F4J8zXNwESG9OeOCY8cpPGGhb8EuqkBJUHRixJJerFsUN8gwK2k9sID?=
 =?us-ascii?q?T9lbT/Py0gOOy/k9X6gLvBFUGprGsN785gYeugtLgZ6snL5wvfbheVFdyos0?=
 =?us-ascii?q?02uNsrI78j3qDl3gmNMCY57wcCQ1fUKr0vLh+USch1AuqWrx9Ln5DZyvJHBn?=
 =?us-ascii?q?/fwt5e9udwnbfw2ysNVFM64TfZKgJE7lHV3uHAQP+mr5iqU0r96k+PRcqv7a?=
 =?us-ascii?q?5f82fyVfOmfOYbKpoFiMfmRiotld8tqqFjQcjxHVHj0CsXq78NUNPmEfPeL0?=
 =?us-ascii?q?XsQowjTeYoeBvB98U+LXePWZ7E/7mKen551ecNuF7QNu59Pmd9q68/FHlWfa?=
 =?us-ascii?q?GHIj9RW/Or0xjVdpJzrre+sHnxUKqCL/NoYFCmyv1dKchnwWyyojmxHMoExT?=
 =?us-ascii?q?UegH9jMZZaNJBGwwP3o0Bq61BIrUNffkltQgcNaxRIgFqbSX0C+q8gg7Bz8n?=
 =?us-ascii?q?DX/cDmqoq95hE+tFnOxkhVJsCJPSoqL7dovLFfmu5i4J9zEd6bBjhCcu4s3I?=
 =?us-ascii?q?1BihENUWjEsrLBaYnP+lXSrRTD0IiNOdL8S38PL2Z0VJGDWlSw13xa2Qjm5c?=
 =?us-ascii?q?TSF/QtHGZXQEFUe3mvdOz706kWCj1Z0vHPG6ZvJ/TCkuVU2qzk1WTHazhvci?=
 =?us-ascii?q?FChnvNGMZXbWvb2sAcT4YL7Y1dctKE6oLwS69TK2Ep26TZ+UekjuTS8c1JJQ?=
 =?us-ascii?q?jw0+ExRY5bsr19bi4PL20CAP1giSOMzVyEvlgSh6d7UWMBGu+L0snZ7StgdU?=
 =?us-ascii?q?a663DNYOrCeanVwAYYWsLESZj8N9aXull7QhRSWfDY5Yibq3dRg65+yZ1LrG?=
 =?us-ascii?q?vxi391c3W2S7PWkeoVAWE+/L6QTvkF+sI4cmwzZGofC3Y1qMLRwzo5RqXK1L?=
 =?us-ascii?q?kU0glp4aHz68+sTt4ZxFfv6zQ2CmvnR6xdBeqGRTYMEm8qYR0JRC2lXH/q6Y?=
 =?us-ascii?q?CoCYmMbi6umrKThxKguh491FJo7e8m5zlV3AG7TaZ8ia5TfVd7QPitYcExSU?=
 =?us-ascii?q?mbMIPDXmz4F813U0omdi+D+5x2zgfOvJ2cJ4C0/3MOfSO2dHc8qHkeEjwNky?=
 =?us-ascii?q?/HPlyrY8N4m5gknA+x9N7pZT1CWBsJAj5d9PIrWmUaCCfYea7RzX9OQPsuDj?=
 =?us-ascii?q?vEv0AxOKujgOpHApub6HiFXqoQWLcg4yVrjd/dLRRwPySulEZe4HZ8O4QUKf?=
 =?us-ascii?q?O30GcxqnzYvkyz9DtRptv4+N2rkrD1YQnqiBqTFRrHRjgLWBHnOkv6hYCshf?=
 =?us-ascii?q?meplOL880osC3xaa4WYQrTmY2NgMa2lz8tyXp4T55tdoME63LKp3tE8/MoaP?=
 =?us-ascii?q?w+vyzkHNhnxCorlTSFwcqqiUe4652qi2rjsmLsSSUDeDakzE8sVhLtB+jgfO?=
 =?us-ascii?q?8+fea1+Iki7O9QEf2IokPD8hjYfJTXPCFqYDobtMx2fzPgUyZhkgSdH89Qnv?=
 =?us-ascii?q?VZmbdjpos1OPQovPVEcmK9beeiVXzlIKd54r2LKXkkBzaTIeCeBlq6/CfHl6?=
 =?us-ascii?q?wWpTvfIM+AVRBcu6a9wZss20OR5yDPXFEWMk0bkkRzyLvuQQXBHJfrOUWBMV?=
 =?us-ascii?q?hzoK0UshzJIq5kvT2/Z1dQQqRVu532ehtzRxqwKVON4RuuAjUUoL/R9DNvwg?=
 =?us-ascii?q?CDnMmRJ0i38G8JW7AZm7sUGc/qqI5vuGEW81kxn53iF6/8yv+e4vvNl35SBu?=
 =?us-ascii?q?j+gdGsKLL+i9SRtp2NBqhNok04HAUHuFEJ22nIsJbfhrIjKUrjux2qPNVzvr?=
 =?us-ascii?q?C0PaB0cwhur6waS895NfroFRA7yjuYQxGrvMJ0pZYHQ3AR2/YxziN07VNJvs?=
 =?us-ascii?q?Q/RZm8RJxzwJ6iFpuasQdf+nQDJ3JRpTGfxy+/vxjMPQ1WStmL3VzAvlzCV2?=
 =?us-ascii?q?9wFRWo8CqrRykkvTtwHK21K4I8otgibeD6erFBr4ElfyIgok72LM7bZnFM1x?=
 =?us-ascii?q?0G3abKIyVMpNa7Gr+kpZXSQBTPsuyHF+3GHImhLm+anr7jy4xvz+6ZefW29U?=
 =?us-ascii?q?FpIiGyvwdtract3jJUU3n1ojm/usT+dj8M6J/CRhLY4Fh4mfTTkFLihbyCzE?=
 =?us-ascii?q?G1DVgh5boRvswcda0BN2FOTtGOmkhZ0NWTHETu+ogOMxZ7mjq6tDyigejn3Q?=
 =?us-ascii?q?y2OhkfMevdP5RDNHkEy7hMQivgCeTH2T7A+RqRPB3CCGcx8C5yFeDVuDUelK?=
 =?us-ascii?q?ZaKKwpyjGRHC92UMafohsqaJNeaT4d7zB66vtPazHgkn9S+I0sMb6GD3cck7?=
 =?us-ascii?q?9kTQ+JeU2uYbCYpPs6u/X/XCsQDo2NFetJ1dPKzvwMSUeYct/gInkbia2foC?=
 =?us-ascii?q?Dy8eI8NmpO9ejYXTkgDdIrBralqWF9QTvm1UbE1b1Qlhttf7s3B9DO29bhF2?=
 =?us-ascii?q?5s+HwbeyhE5N27FmAb8JM6+/7UWL7zMOToY93zt1q2i9RqjGdpsSc7o+A4eQ?=
 =?us-ascii?q?Or7zS4PHMDosEEL2+KKfdIPfdm9PPJewUGTVS9d7Z0iIizjNw625nAy5pZnp?=
 =?us-ascii?q?3MQtdnx5R2HWzcckdfKwf+qAe1/gsNPcPPUqPM1mf2QbLFBeTdrrslxIv3um?=
 =?us-ascii?q?mLzj7asNQDgz342llK+iyLTdLsLrZAXE0SkwhmhBGM/h2hlPWpcVyzP+qquL?=
 =?us-ascii?q?QV9VIGSGx2VqyW5dOKzub8fscDsOakPpVDc4fGYxZlL50nxX+LutNdNnVfSF?=
 =?us-ascii?q?+2JMzLlTEetfnfp3Mv0IwyATg=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.93,192,1654574400"; 
   d="scan'208";a="76538133"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2022 06:08:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsLLPZJ38NBz+/6y+kU3QOR7VzsLR2172wwiGFGmnFRFcUVBKp/NVto0zH+JwNg8G651VKR/KIuQPVYbHHolTqNWoCbUhEvMfpVTlNUWMU4dbjsZE5gzGQAWgfEh1V6Hix45H5nPjNRDrTDmfNcyy3LHF8LF36EGc7iYTO/l9BVx6HyhTkDD4HqeZdWR5+OOQovFZgSugp2MDiz6QLLt5FBZb+fRd0byRaLhMt3v5dBmwQJnh1RimTYAT7GMcv4wQ2rKUGGaddnPihqroyRowycjSlR5sEP6Mk4YlskcOeehDMNLX8fOmNcp/1A3OefJMgHor7HYBDC6JIENIyyMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqItF+M2OU5sj85TVLt33ajlOHQoYByO3WX7XoCmzRM=;
 b=L3HxC5I4H0XpqXYpt4MfPH5d2TkHDxbwzxWja9B1Kn5TrosGzV2xQHm0qn1vEiLXh6pV65BdoBl9pP9kPpg/N31Wc8ygWiJgsI5Qi2QhRk/5nFBtWDMb8yw2DFJ5WOFtEwYnoAct6p47VQJ5JX8rUK78ZzqhNNslg/2bPlGW6uGnLqHI+/3YGEx2qKGtmO1r0IMQwhaEGq48VspD30qrHdrmCE79wTGmYon8b+LxUzbvFRJI6Plh0N+Zhxem5M1OKDSB2jD8KEHEDoacmRE/jKVFKN+Q5cI3hiOYQWBgJSXpjiHcBIEXXqCAX2uA+9vDyFqOQUQXuz9hxkWMywfjRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqItF+M2OU5sj85TVLt33ajlOHQoYByO3WX7XoCmzRM=;
 b=oh5MUoUgPM4tYzwbDJ2s3MkeIyglR3X/r9uW8y8XFKiSo+8YxiZAkfSkj6WNlQaYC0didcOzJMkKXl0rC7kzgLDIkTY6Dac6NLm2/+Y3RfJ5v/jWSo68jX1gfHTFqy+82/AHC7dRT3XTF/O3zGqV1KmG9VweUshNixqeRFzQQ10=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by PH0PR03MB7017.namprd03.prod.outlook.com (2603:10b6:510:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Mon, 25 Jul
 2022 10:08:45 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd46:feab:b3:4a5c]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd46:feab:b3:4a5c%4]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 10:08:44 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jane Malalane <Jane.Malalane@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Jan Beulich <jbeulich@suse.com>,
        Colin Ian King <colin.king@intel.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] x86/xen: Add support for HVMOP_set_evtchn_upcall_vector
Thread-Topic: [PATCH] x86/xen: Add support for HVMOP_set_evtchn_upcall_vector
Thread-Index: AQHYlToncjhzapb0rEGq8Bkg0N3t9a189b0AgAImuYCAABmhgIAAOBoAgARvxACAAFS4gIAKv+oA
Date:   Mon, 25 Jul 2022 10:08:44 +0000
Message-ID: <4cf1f190-60d8-6bfc-f339-334bbefff299@citrix.com>
References: <20220711152230.17749-1-jane.malalane@citrix.com>
 <272ea76d-0099-873e-b8a8-1cc43b7b1e11@oracle.com>
 <0b5ec408-197c-7e34-28d8-7505e1f031df@citrix.com>
 <01cc9e39-242a-3cbf-13b3-cb3ecccd5737@citrix.com>
 <3be61417-6e58-1d9f-dd3c-7de00daa8d0a@oracle.com>
 <c9aafc28-e93f-ebe4-b591-0edab4efdf2b@citrix.com>
 <41198c6c-22ad-1530-793a-e557f3c09415@oracle.com>
In-Reply-To: <41198c6c-22ad-1530-793a-e557f3c09415@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d4c301c-b7ee-47f0-bbb2-08da6e25a882
x-ms-traffictypediagnostic: PH0PR03MB7017:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9m9Cne3O3UCjxSqQEURoJ/tiKQ9N+HpGgwzpSTcAlk8E3gydPAZCM8ivT+S/e6KYJnyWi8rxrUOwTa2MkPaHz7ueevaUeq7dMYGjNfKXS9/EDQ/zX7ZI9TPIomZeaECxoLb0ztfdXUPlrDCnHAabYrxvsw6B4Xlke4ZcgnRmkyfan48Laoq3u/rlQf/fDRYoqYkT6gY+MFmCTVWxL3NtdLEulIMwW8ltexufV0/SVxTPZCstLgrcBfnFUrRLCrn8EW/nGo65oyDI7eRh6txrO7OldyPTi/QykQYoBUkRI7iCRO2AG8heyYqYEDJqryPMVrFAjTHrUxrizMZ/xbeOLv1UnGTefwNvHe9N7US5SPb0FPpWNN+B+X2K+SKM3Lrb16S01CAZtozel53fmUzCxSqDLp1FGEXOKInWQbgB+Yv4T5TY2mpCVQ/vZ5WRtdw74kHiDWnb2Sam0tz5kn86Sg34h1qFU1y1aNSvL3PuaQyIeGy0Y4vaGt8ccaX+UmweVSZbNFkF6dyfmp0axFL3uRavWfPBidA3mZpUAxYdN3t325bC6CNYh7cnJFPO+n56uxl4OfmWL5c32SuUxn6frYix7bNvnN+qB1SuRHoY1GK20XdME8tFhpgKA6VLAzsoOoEvzpXu1WpfOeGuyZ+J4J8gyF6lEToSSAR3LfyeyDgAAgEnSSsknHV6PfJC8ZuyHU5wgAkebsTsmPdPSn67wSGFfWzJdbcNfTmYC+IAPjuZ18GFbVooLJ+TfIyJav+w7qw3elsPrl6rsASt3ZtYDVwoHWd8AKZ6S8UGKuuL0eqvNhmoNM/u1EDxPPv5jqZmCh1pR7+v/PAZ3I97MmCiGXYd61VoVuE9r2iUMR8qJ+PGn9T6PiS/LsZRS5jz9+Px
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(122000001)(6486002)(38070700005)(38100700002)(86362001)(82960400001)(478600001)(31696002)(7416002)(5660300002)(8936002)(316002)(41300700001)(54906003)(66476007)(66556008)(91956017)(66946007)(8676002)(76116006)(71200400001)(110136005)(83380400001)(53546011)(36756003)(186003)(2906002)(2616005)(6512007)(26005)(31686004)(64756008)(66446008)(6506007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFMzUnFERm1qbFJQY0RKMWhIZFVLN0xJZmlDS2F1d0FKMXYwdS9mbjY4ZzZT?=
 =?utf-8?B?NGNPMjg0SEpVTVVvK1RscEttNW03dVcrZmtqMEt1Z1JQZlZaTGo3RlBRajNS?=
 =?utf-8?B?T3dCUkZwU1EwelU1dEV6VnVzaURVUHdxRFpXdkpVekcyS1hUUTJLalJRU3pj?=
 =?utf-8?B?aUpmcURVTUN2STBlNENPQkI2aG5SZzVQZW9BKzN1M3QvVjN2eVNZZlYrSXFE?=
 =?utf-8?B?aEJjRmhMMjd4NCs1ekhjY3k5YW5JY2M5amsxNytaZ2pNQVNIdjNmT0xwUXh6?=
 =?utf-8?B?MmxDZ3ptTG1YOVk3V0h2Tk1BQUVkNUtvZTFsd1VWQXFMYmlUL2YyOEZzaFZ1?=
 =?utf-8?B?TElRckVaTFltaUJLajdBb0dKUEFkWlhnSjZkd0lMS2lzb0RaWVdyYTFpeEdw?=
 =?utf-8?B?RkVPOUhGZ3M1TXJxSERucW1IVTlzbzdhcUM0eXNpZHB3YjV3aTM2bTFCRytZ?=
 =?utf-8?B?bk1NRk15NHFpbS9sOEIwQXdUSTQ4SWp3eGlIU2VWSVR6VjdZUHI5MXRLYlhy?=
 =?utf-8?B?U1VWMlYwbWpYQ2RHelA1UHBVcjV4bDJLdVlPbXpJRkpTMnE0NzIxSnFIOHVG?=
 =?utf-8?B?UTl0SUE0UVJZRUlCU1VtZTVhR25DVW5sV1JKV0NPRzRUelZFNGJ1cnUxN3VY?=
 =?utf-8?B?VEdQY3V4R3ZCWmVITkIvTzExTkZyNlRwaWtTc2lQRWVmVnI0MmtTU05DS0ZD?=
 =?utf-8?B?WjYrenZPamRVeXRJTXBVdGQxL1UxUlBGSmMxd2lCU3hWWURjQUpzcHA2dXph?=
 =?utf-8?B?bXlLRzZYNFllTVlaSmsrNWtvRitORFA1a2Q1VU40N0NKcVBZNGlLeUVRMEpR?=
 =?utf-8?B?cERpYkVTOHFmaWRtT3dkU2Vyd203bThtaSt3UnFLMkZLVWRreGYwM1VkZFdE?=
 =?utf-8?B?NWQ4aTZXTzk1cDRqNnpwaHRwTGhlRkZ5eUJpTWJpVEpTMWI5a3JzOVpsZGJu?=
 =?utf-8?B?Q1FNOEpYUk1wMkpVZGJHNVhENWF0VzFCRFR5RUY2cWRIK0MvR3M2ZEo1MGEx?=
 =?utf-8?B?SGc5RWpETisrWC94THkzMFFpUFhuTGc0VUtNVFQ5cHBCUDhGZkN1RmcvVjE4?=
 =?utf-8?B?TmZ3N1JnZTl2THFWbjBrTE5FRjZBUForZVZxdkZDZDBLM0ExY0V5ZGtQL0JB?=
 =?utf-8?B?N1pJZEk0ano5Z0tHRnRIa3FuUUJ6WkVWWWdqM1FmNUpXVno0d2JOUC82Q1Y4?=
 =?utf-8?B?aHovdXhZZm9nd0FMckZhOTAvajE0bktjRG5NcGNqQnU2eG10L2pUcEFMa3Br?=
 =?utf-8?B?cm9teGNLQ2t3c1U5VDVySjFKNWxXbjFUN28rZE9lZFdKZlpBeDZ4dnpBay85?=
 =?utf-8?B?ekdHQWxXV0FLY0p5L0dBcEh2VWZEVWFsQVd0KzJWS0MxSGlPRDBrN3dIL2pw?=
 =?utf-8?B?OTUzSlNnSlBpVXBqeFROZGJaWkVzeDg3d1l4WWhoL0Zycld0eDF6SnJsdzR6?=
 =?utf-8?B?WFJ0akdPSElDa25ETG50UmZ5VXNGTEM5VFV6b0lmTFB2SjlzMmx4WVUvSWJt?=
 =?utf-8?B?Tk1qM2c1VmFnOWVjL2xpTUsxblE3WDBKL2VobC9CVEpSMXdiOFAwQ2MxMVE4?=
 =?utf-8?B?NEZIQ2NsRlFoYVcxQTBsbEJwaWNQY3dOeGJlNmFsL25LamxWVTU5TG16Uzd5?=
 =?utf-8?B?b1ZLTHhNOVNXaEJ6b0svVFdLRkFPckNBeWV1M05NcTlXL2NwV3pRanBoTkRE?=
 =?utf-8?B?cU53QlNpTG9KY3d1NEFZZCtiTTJrMHcrSDIxWmpPSW5sc21WbUNOT2hibXhR?=
 =?utf-8?B?NWZWemd0OU4xTGpxQ1NnZXJKR29QZlRYcjdZQ3Bpd0RQT0JLVzB2R3ZBQjdR?=
 =?utf-8?B?cUtQK1ZSYW1uQm4wOFhkS05XVnBFd0VZOSszcU85di9QQ0tNSzh4NDVMR1pn?=
 =?utf-8?B?SW5rc0pZNTcydzlwMDhRSk1pdm43QXRtMEdpeW40WW9YRUNxVVh3S0RZZmg5?=
 =?utf-8?B?cE5wSTQ2TGNGMzR2cWkrVFltdmQ0WWlZSHVEd1R1VDlGM3VJNDkvWnNJNGNI?=
 =?utf-8?B?MXdtcjFXNXUvS3FNc29MOGtEVTZEbzZYRzRneDVvMkdscmpLR0VpL21KREpS?=
 =?utf-8?B?bUZjYWJKZ2FZSkUrWmJ6QlB4L2FtZG9wSU5FandEdk5RbHp3aGo3YklQRVRx?=
 =?utf-8?Q?cU6AvlovHs2rIirPQQV2UKTjf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32FBC27E3FBA21478D20D2E74D8264FC@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4c301c-b7ee-47f0-bbb2-08da6e25a882
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 10:08:44.6019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N3I3RxBGiclKxZqXCZhSV8xfpEqfG2dDybawzBqgus8c+R+P1GmZn5PLa9jY9DrQAa8duRWIRTjbfefm03i4Z5Jz/JZwR78yH8SeeSoe0OE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7017
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMDcvMjAyMiAxNDo1OSwgQm9yaXMgT3N0cm92c2t5IHdyb3RlOg0KPg0KPiBPbiA3LzE4
LzIyIDQ6NTYgQU0sIEFuZHJldyBDb29wZXIgd3JvdGU6DQo+PiBPbiAxNS8wNy8yMDIyIDE0OjEw
LCBCb3JpcyBPc3Ryb3Zza3kgd3JvdGU6DQo+Pj4gT24gNy8xNS8yMiA1OjUwIEFNLCBBbmRyZXcg
Q29vcGVyIHdyb3RlOg0KPj4+PiBPbiAxNS8wNy8yMDIyIDA5OjE4LCBKYW5lIE1hbGFsYW5lIHdy
b3RlOg0KPj4+Pj4gT24gMTQvMDcvMjAyMiAwMDoyNywgQm9yaXMgT3N0cm92c2t5IHdyb3RlOg0K
Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoCB4ZW5faHZtX3NtcF9pbml0KCk7DQo+Pj4+Pj4+IMKgwqDC
oMKgwqDCoMKgIFdBUk5fT04oeGVuX2NwdWhwX3NldHVwKHhlbl9jcHVfdXBfcHJlcGFyZV9odm0s
DQo+Pj4+Pj4+IHhlbl9jcHVfZGVhZF9odm0pKTsNCj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L3hlbi9zdXNwZW5kX2h2bS5jDQo+Pj4+Pj4+IGIvYXJjaC94ODYveGVuL3N1c3BlbmRfaHZt
LmMNCj4+Pj4+Pj4gaW5kZXggOWQ1NDhiMGM3NzJmLi5iZTY2ZTAyN2VmMjggMTAwNjQ0DQo+Pj4+
Pj4+IC0tLSBhL2FyY2gveDg2L3hlbi9zdXNwZW5kX2h2bS5jDQo+Pj4+Pj4+ICsrKyBiL2FyY2gv
eDg2L3hlbi9zdXNwZW5kX2h2bS5jDQo+Pj4+Pj4+IEBAIC01LDYgKzUsNyBAQA0KPj4+Pj4+PiDC
oMKgwqAgI2luY2x1ZGUgPHhlbi9odm0uaD4NCj4+Pj4+Pj4gwqDCoMKgICNpbmNsdWRlIDx4ZW4v
ZmVhdHVyZXMuaD4NCj4+Pj4+Pj4gwqDCoMKgICNpbmNsdWRlIDx4ZW4vaW50ZXJmYWNlL2ZlYXR1
cmVzLmg+DQo+Pj4+Pj4+ICsjaW5jbHVkZSA8eGVuL2V2ZW50cy5oPg0KPj4+Pj4+PiDCoMKgwqAg
I2luY2x1ZGUgInhlbi1vcHMuaCINCj4+Pj4+Pj4gQEAgLTE0LDYgKzE1LDIzIEBAIHZvaWQgeGVu
X2h2bV9wb3N0X3N1c3BlbmQoaW50IHN1c3BlbmRfY2FuY2VsbGVkKQ0KPj4+Pj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHhlbl9odm1faW5pdF9zaGFyZWRfaW5mbygpOw0KPj4+Pj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHhlbl92Y3B1X3Jlc3RvcmUoKTsNCj4+Pj4+Pj4gwqDCoMKgwqDC
oMKgwqAgfQ0KPj4+Pj4+PiAtwqDCoMKgIHhlbl9zZXR1cF9jYWxsYmFja192ZWN0b3IoKTsNCj4+
Pj4+Pj4gK8KgwqDCoCBpZiAoeGVuX2Fja191cGNhbGwpIHsNCj4+Pj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIHVuc2lnbmVkIGludCBjcHU7DQo+Pj4+Pj4+ICsNCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IGZvcl9lYWNoX29ubGluZV9jcHUoY3B1KSB7DQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHhlbl9odm1fZXZ0Y2huX3VwY2FsbF92ZWN0b3JfdCBvcCA9IHsNCj4+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC52ZWN0b3IgPSBIWVBFUlZJU09SX0NB
TExCQUNLX1ZFQ1RPUiwNCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC52Y3B1ID0gcGVyX2NwdSh4ZW5fdmNwdV9pZCwgY3B1KSwNCj4+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfTsNCj4+Pj4+Pj4gKw0KPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoA0KPj4+Pj4+PiBCVUdfT04oSFlQRVJWSVNPUl9odm1fb3AoSFZNT1Bfc2V0X2V2dGNo
bl91cGNhbGxfdmVjdG9yLA0KPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICZvcCkpOw0KPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAvKiBUcmljayB0b29sc3RhY2sgdG8gdGhpbmsgd2UgYXJlIGVubGlnaHRlbmVkLiAqLw0KPj4+
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWNwdSkNCj4+Pj4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCVUdfT04oeGVuX3NldF9jYWxsYmFja192aWEoMSkpOw0K
Pj4+Pj4+IFdoYXQgYXJlIHlvdSB0cnlpbmcgdG8gbWFrZSB0aGUgdG9vbHN0YWNrIGF3YXJlIG9m
PyBUaGF0IHdlIGhhdmUgKmEqDQo+Pj4+Pj4gY2FsbGJhY2sgKGVpdGhlciBnbG9iYWwgb3IgcGVy
Y3B1KT8NCj4+Pj4+IFllcywgc3BlY2lmaWNhbGx5IGZvciB0aGUgY2hlY2sgaW4gbGlieGxfX2Rv
bWFpbl9wdmNvbnRyb2xfYXZhaWxhYmxlLg0KPj4+PiBBbmQgb3RoZXJzLg0KPj4+Pg0KPj4+PiBU
aGlzIGlzIGFsbCBhIGdpYW50IGJvZGdlLCBidXQgYmFzaWNhbGx5IGEgbG90IG9mIHRvb2xpbmcg
dXNlcyB0aGUNCj4+Pj4gbm9uLXplcm8tbmVzcyBvZiB0aGUgQ0FMTEJBQ0tfVklBIHBhcmFtIHRv
IGRldGVybWluZSB3aGV0aGVyIHRoZSBWTQ0KPj4+PiBoYXMNCj4+Pj4gWGVuLWF3YXJlIGRyaXZl
cnMgbG9hZGVkIG9yIG5vdC4NCj4+Pj4NCj4+Pj4gVGhlIHZhbHVlIDEgaXMgYSBDQUxMQkFDS19W
SUEgdmFsdWUgd2hpY2ggZW5jb2RlcyBHU0kgMSwgYW5kIHRoZSBvbmx5DQo+Pj4+IHJlYXNvbiB0
aGlzIGRvZXNuJ3QgZXhwbG9kZSBldmVyeXdoZXJlIGlzIGJlY2F1c2UgdGhlDQo+Pj4+IGV2dGNo
bl91cGNhbGxfdmVjdG9yIHJlZ2lzdHJhdGlvbiB0YWtlcyBwcmlvcml0eSBvdmVyIEdTSSBkZWxp
dmVyeS4NCj4+Pj4NCj4+Pj4gVGhpcyBpcyBkZWNhZGVzIG9mIHRlY2ggZGVidCBwaWxlZCBvbiB0
b3Agb2YgdGVjaCBkZWJ0Lg0KPj4+DQo+Pj4gRmVlbHMgbGlrZSBpdCAoc2V0dGluZyB0aGUgY2Fs
bGJhY2sgcGFyYW1ldGVyKSBpcyBzb21ldGhpbmcgdGhhdCB0aGUNCj4+PiBoeXBlcnZpc29yIHNo
b3VsZCBkbyAtLS0gbm8gbmVlZCB0byBleHBvc2UgZ3Vlc3RzIHRvIHRoaXMuDQo+PiBTZW5zaWJs
ZSBvciBub3QsIGl0IGlzIHRoZSBBQkkuDQo+Pg0KPj4gTGludXggc3RpbGwgbmVlZHMgdG8gd29y
ayAobmljZWx5KSB3aXRoIG9sZGVyIFhlbidzIGluIHRoZSB3b3JsZCwgYW5kIHdlDQo+PiBjYW4n
dCBqdXN0IHJldHJvZml0IGEgY2hhbmdlIGluIHRoZSBoeXBlcnZpc29yIHdoaWNoIHNheXMgImJ0
dywgdGhpcyBBQkkNCj4+IHdlJ3ZlIGp1c3QgY2hhbmdlZCBub3cgaGFzIGEgc2lkZSBlZmZlY3Qg
b2YgbW9kaWZ5aW5nIGEgZmllbGQgdGhhdCB5b3UNCj4+IGFsc28gbG9naWNhbGx5IG93biIuDQo+
DQo+DQo+IFRoZSBoeXBlcmNhbGwgaGFzIGJlZW4gYXJvdW5kIGZvciBhIHdoaWxlIHNvIEkgdW5k
ZXJzdGFuZCBBQkkgY29uY2VybnMNCj4gdGhlcmUgYnV0IFhFTl9IVk1fQ1BVSURfVVBDQUxMX1ZF
Q1RPUiB3YXMgaW50cm9kdWNlZCBvbmx5IGEgbW9udGggYWdvLg0KPiBXaHkgbm90IHRpZSBwcmVz
ZW5jZSBvZiB0aGlzIGJpdCB0byBubyBsb25nZXIgaGF2aW5nIHRvIGV4cGxpY2l0bHkgc2V0DQo+
IHRoZSBjYWxsYmFjayBmaWVsZD8NCg0KQmVjYXVzZSB0aGF0J3MgYSBicmVha2luZyBjaGFuZ2Ug
Zm9yIH41IHllYXJzIG9mIHdpbmRvd3MgZHJpdmVycy4NCg0KfkFuZHJldw0K
