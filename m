Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB8D495164
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376553AbiATPZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:25:56 -0500
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:6185 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiATPZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1642692348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=uz8uGhqvkVx+fQNRc6I6RtZfkTU8YzTQPI9wTYzWFkY=;
  b=eXNWRlEMiHKqrBvcFJM8n7dwo/LX2RDnqIBNsH9NdUZl3ezZuzz0wZYa
   rvbuoReCqDIII9EsWdvFhCKdLGhmnEk9xWHOaHicsoptDoe/NmCjZbtkf
   OPsMOAAfwiCh/B32W41UBdwp7BVbwJoeVsnxwK/oHZ/5+1iNFoQMwntAI
   Y=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: vI23O9fr9kvTuYra5npa+GLAJvnPG9LdTMKjKCQT3CibmCNXaDfWZA0b2itn/1ci/CWhaJiPMq
 VItrBc1K44ixyvPSnQZsWWmWWxVR1jj2UfoeM3RvcHcEsPaQZ92BL/QLpiTquf4cJhJHNq7dwx
 6HwbF1+R9FsRGABb3UsHlYvCB178BMcp3FQsXRwoFJ+oWsvOAGXZdzUWuBrHaxyHF9g9AGMWZr
 rbmhAh4oxU0b+ArM5+4aRFUFW4o69vIhj8rJ5sSafOWWpkMHlSa0KzXbKcyaUbJQSOrguaxUYx
 z/0ZZ0/qO6m79Ya7y7tMIPW6
X-SBRS: 5.2
X-MesageID: 62414704
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:935kMahlozSpAkAXEeV0LMpcX161fRYKZh0ujC45NGQN5FlHY01je
 htvWj+PP/yNYzCjKYx0aNi290oGvsKDmNJgSgs6qys0EHkb9cadCdqndUqhZCn6wu8v7a5EA
 2fyTvGacajYm1eF/k/F3oAMKRCQ7InQLlbGILes1htZGEk0GE/NtTo5w7Rj2tcy2YDja++wk
 YiaT/P3aQfNNwFcagr424rbwP+4lK2v0N+wlgVWicFj5DcypVFMZH4sDfjZw0/DaptVBoaHq
 9Prl9lVyI97EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPg/W+5PwZG8O4whlkeydx
 /1EuJ6CcTYMH5HCt/wAYTVcNi9xPoFJreqvzXiX6aR/zmXDenrohf5vEFs3LcsT/eMf7WNmr
 KJCbmpXN1ba2rzwkOnTpupE36zPKOHxO4wSoDd4xCzxBvc6W5HTBa7N4Le02R9u3JwXQamGO
 6L1bxJKbEvGTiFjMWsOJ5YAgunvoCOuTm1X/Qf9Sa0fvDGIkV0ZPKLWGNbcZNHMRcxThUuej
 mbH+XnpRBAcKNGbjzGC9xqEjPfnlCf6VYRCUrG1ntZ60AO7xWEJDhASE1yhrpGRmkO4Ht5SN
 UEQ0i4vtrQpslymSMHnWB+1q2LCuQQTM/JQC+QS+hCRzbCS6AGcbkABTzhOb/Q8ucM2TCBs3
 ViM9/vjAiZuq/uSUm6H8amPriKaPjIcJmsPIyQDSGMt59jlvZF2jR/VSNtnOLC6g8ezGjzqx
 T2O6i8kiN07j8ER0L6g1UvamD/qrZ/MJiYp6QHHdmak6B5lfomjZpzu5VWzxe1bMI+TQ12Fv
 X4Fs8uT9uYDCdeKjiPlfQkWNOj3vbDfamSa2AMxWcl6n9iwx5K9VYld4gNGFWJIDsgrYSLbT
 Ev2twxSyJAGaRNGcpRLS462Ds0ry43pGtLkSu3YY7JyX3RhSOOU1HowPBDNhggBhGBpyPhiY
 snDLa5AGF5DUfw/pAdaUdvxxlPCKsoW4WrIDa72wB28uVZ1TC7EEOxVWLdigw1Q0U9lnOk32
 4oOXydp408GOAEbXsUx2dRPRbztBSJqba0aU+QNKoa+zvNOQQnN8cP5z7I7YJBClK9IjOrO9
 XzVchYGlACh3CKXdVvWMyALhFbTsXBX9y5T0csEZg7A5pTeSdz3sPd3m2UfINHLC9CPPdYrF
 qJYKq1s89xESyjd+iR1UHUOhNcKSfhfvirXZ3DNSGFmJ/ZIHlWVkve5IFeH3HRQX0Kf6Jtvy
 5X9h1izacdSGGxf4DP+NajHI6WZ5yZNwYqfniLgf7FuRakb2NE6cnOq1q5ufZhkxNeq7mLy6
 jt6yCww/IHli4Q07MPIleaDqYKoGPF5BU1UAy/Q6rPeCMUQ1jHLLVZoXLnacDbDennz/an+N
 +xZw+ulaK8MnUpQspo6GLFulPps69zqrr5c7wJlAHSUMAj7VuI+eiGLjZtVq6lA5r5Fog/qC
 EiBzcZXZOeSM8T/HV9PeAd8Nraf1esZkyX55OguJBmo/zd++beKCB0APxSFhCFHAqFyNYcpn
 bUotMIMslTtgRs2KNeWyCtT8j3UfHAHVqwmsLAcAZPq1VV3mg0TP8SEB3avsp+VathKPk07G
 ROuhfLP1+ZG207PU3svDnyRj+BTsosD5UJRx1gYKlXXxtec3q0r3Adc+CgcRxhOykkVyPp6P
 2VmOhEnJaiK+Ds01sFPU3r1RlNEDRydvEfw10EIhCvSSEzxDj7BK2g0OOCs+kEF8j0DImgHr
 e/AkGu1Ayz3eMzR3zcpXR83ovPuetV96wnelZ31BM+CBZQ7PWLoj6LGibDkcPc77RfdXHH6m
 NQ=
IronPort-HdrOrdr: A9a23:9MFM6auT/jM0NUbVxD8KyBLT7skC7oMji2hC6mlwRA09TyXGra
 +TdaUguSMc1gx9ZJhBo7G90KnpewK5yXcT2/hsAV7CZniahILMFu9fBOTZslvd8kHFh4xgPO
 JbAtND4b7LfClHZKTBkXCF+r8bqbHtmsDY5ts2jU0dNz2CA5sQkTuRYTzrdXGeKjM2YKbQQ/
 Gnl7V6TnebCD8qR/X+IkNAc/nIptXNmp6jSRkaByQ/4A3LqT+z8rb1HzWRwx9bClp0sPof2F
 mAtza8yrSosvm9xBOZ/2jP765OkN+k7tdYHsSDhuUcNz2poAe1Y4ZKXaGEoVkO0auSwWdvtO
 OJjwYrPsx15X+UVmapoSH10w2l6zoq42+K8y7vvVLT5ejCAB4qActIgoxUNjHD7VA7gd162K
 VXm0qEqpt+F3r77WrAzumNcysvulu/oHIkn+JWpWdYS5EiZLhYqpFa1F9JEa0HADnx5OkcYa
 ZT5fnnlbZrmG6hHjPkVjEF+q3vYp1zJGbLfqE6gL3V79AM90oJinfxx6Qk7wA9HdwGOt15Dt
 //Q9dVfYd1P7srhJJGdZc8qPSMex7wqGr3QRqvyHTcZeg60iH22tbKCItc3pDeRHVP9up0pK
 j8
X-IronPort-AV: E=Sophos;i="5.88,302,1635220800"; 
   d="scan'208";a="62414704"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1R2UJKSIgVaTV0M51/BgKZ1j9Db9K5wA+q9qcZJAFzD+AFROGT1lPuGba9IPIxJiCsGMaufsRyKXEeG7KzHkj89wSOpnVITpK0lM6NRl6CxBpI+z9G7Fowg6Q7+sCitEkoPeopSRCDN5MCZ3AxnZPovM0YnBcKHe479aq2SIv81OyN2rnowjpNGLU5hJFlrdRjuNLkmOeLV/2fBkucwaRDjs4BzVuaLJk8IdbYGc/tHtQZ3FiiS5OqnMUx9Yo7rVhtD9r9OY3imF/Dwp9eWJHFYrph0JX0d5RsPXWh+p5K3cTJlI+b7jjisj9oDizb/yMOxxWHHWp9M2z5G8FtoXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVhmLB8WRhPIHIhc72MTOVuVpcpi8smodcvRNNMHH+Y=;
 b=YhX7bw2Ceqdnu8gvgtcf7GhIQbRe2bu5+c/2qVs9DbH7a500pNTSTIbwTldfysb/BPSZt5tZX0K0M6Ke396Y6/vpm2sT9JioBOa7alfpxdHuqhlYhJK9ubShIN/qGQqVGBLSHJk9GAYndZDdguUMJZBsfsGoqmH9SS6C+1cct+C9igSHrXz+Xeur+QezILl1kRJfCgabUQvFWbk0pXK5zdkvZeeVA8vbhPMY81nVCOTQdqnd9rER6eJnsryYhZJaz3bS3jiXO506idx/uR6zHUfALBlNvnut/tjzLJn/rFj72zfS0uGNR2q8qgHyHiqmAccGucvV5tinkVJOJ1ebpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVhmLB8WRhPIHIhc72MTOVuVpcpi8smodcvRNNMHH+Y=;
 b=fUwO8ksP1Qk+EiXF+s3BOGthfHja5+QdmwCmjKT+M/a2iNWWS8rhxAqQ2US6fw5BKuwhyPdttSoH8JXOpNmBJbB53FlBMqUyEKgCwcnTHMC9hWxsskNvO5IwsJHIrYIO9q2LMyruzoRyZNThvXVzu/A12RuhrsFH8NrsxgODhXo=
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <xen-devel@lists.xenproject.org>
Subject: [PATCH 1/2] xen/x2apic: enable x2apic mode when supported
Date:   Thu, 20 Jan 2022 16:25:26 +0100
Message-ID: <20220120152527.7524-2-roger.pau@citrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120152527.7524-1-roger.pau@citrix.com>
References: <20220120152527.7524-1-roger.pau@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::18) To DS7PR03MB5608.namprd03.prod.outlook.com
 (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65654750-3101-419a-7847-08d9dc292098
X-MS-TrafficTypeDiagnostic: SA0PR03MB5468:EE_
X-Microsoft-Antispam-PRVS: <SA0PR03MB546838D23C8BF9FDB69CF1F38F5A9@SA0PR03MB5468.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZIJdU3EvJ7rLAg0sdys10uG+cLTmCd3cLsz0qRDR8mNWqueG1TTaIti42T385GpWlzSKFou+LBc8MUNg0AlK4r7QbLtSk8+lTi70OmYn4o3f66leCocB/hNwbkxkQhw0Hx3XZgNeVF586/U4Je6Nk5b71GHRzW+GJEggnaGTpt26wAoCWvJeiygVu2zsiJE3O5+xH2Id6VFYGrT/AEFd8jkJ65aqTpnMfT61mfARr5L1KyzlZgDNpa1IFiKBgpJ8p8KsivK3X/XdB7sbTB4fY8YbrlP9OxmHrErsGGRQg2SYoCzoLlF3vVQNHwh4u2PiZr5w3lZaiqXPHzrH2eWHfMSwyg8kacM82XWunU9uaRhtO7Zf4Xa94EjZUqIGiykmaA9+HImAT5vFmI19b4ySmTzGnVO63NtcFDhqExQ/5b7zNHzOP+RvkV9BGr1mTuRV9ymwwVrFNaH6LD4v+k80Rk4oL7ISRa7qr77Mu5oYBXqizNBD6Ye528sXMZpno4yRI/GDP+5WohpFrv7AY3+iNR6CQjMei49n5Oh1RWo4c1YORR1RrxibrDXGgljVzrz7WfF1W7Ox5Ow6BXjy15CyEce6CY5o1ceS5jnGJMEDwYnEaFdFHoG2yWJdfjSCOLmN74XmFJfAShasFuAMLYu/3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5608.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(6512007)(6486002)(6666004)(82960400001)(66476007)(66556008)(6916009)(7416002)(54906003)(316002)(8936002)(36756003)(66946007)(508600001)(83380400001)(5660300002)(186003)(38100700002)(26005)(6506007)(2616005)(2906002)(1076003)(4326008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnc5UVByQWNhNFBWdTZQRnc2NHZvRXNjMjZEWlFNL1BiMm5GTEljVUdzL0Jn?=
 =?utf-8?B?dmFkRmpBTzVLL3duc2xjbmhrVlRWVXNCMk0xUFpUTjRPai9JVUZ6dTU5UGxp?=
 =?utf-8?B?RW1LTTVzTCtPYXZyY1QxWk9KNEpwZTdSRkhWdGF1cEY5RjQrdUZUUENYY0Vn?=
 =?utf-8?B?UnFZLzlJK0Y3VnhiQmJScnFxZENGR1NJZkV0ZTcvdlp1QTQxWVVabE13cEN2?=
 =?utf-8?B?TWtLRWlZRG53MFBXYWY2NDhXcGhsNHpLblJXMnVuNUcweGpkZnBZMU9FZTNl?=
 =?utf-8?B?RDcrKytRcjRyZHFOZThmWFNKNVliNzUyT3pvTng3UzhGeWxwMldBUXNETzFt?=
 =?utf-8?B?cG1RN1RMeFNXQkZLNG04OE9Ob3g1YWRXUy9PY2JlVVhZdFAzaTBzaVBVdkJr?=
 =?utf-8?B?czZxMEs4c2NVb2NOVGt3dW5wTkQvdUZIZmQvUlJWcXJqZ1FaUlQ1Tm1zWmZP?=
 =?utf-8?B?NFpHT0poZXcvcFErVllLRFpqaDdRV3Mwa3pSenVoNngrZmdhM1oxbVRHZnlK?=
 =?utf-8?B?MFU4d3FGTnJwdkwzOVB6VnczKzZzYmVPRGpvWm40c2NJZzEvUUhYVlU5d1RC?=
 =?utf-8?B?U0ZyWSt0cC92dStkR2RhQTNsblEyQWN2VzF3QnNldGVBYU5yK0I0TlhSbDB4?=
 =?utf-8?B?TkJqZGpGS0tlRk5XSGxvakZkN09TM0FhaHlhcmk5eW9ReDBUN0hZMHZRendD?=
 =?utf-8?B?QlNibHptVTE3R3B1VmVTcG9iRFVuVEFqc3BpaVExM0tRWUo1OFhMc1hNbFFW?=
 =?utf-8?B?UURuUW4vcWVjSEpNanJjamVYVWk1MnpaQVRKNWsrUWZoY3l0YkRUckxJSTds?=
 =?utf-8?B?WkpsanJxeUd0R1IzMzRIbjREUHNLc1RjRjlDNnpBNFVBTW9TQkt1K29HZS9E?=
 =?utf-8?B?WXpBWUdjeThXWGNwN0o4SlpoSExaN25WbjJtdmlZQUFYQXJaZDFTQ2RTaDJU?=
 =?utf-8?B?cTZ6czJqOC9pc0FCY0FQRGZxMUJnYy8rZzdVd2ZUWGVsdUgzbTlQOVl2Zkhx?=
 =?utf-8?B?OVlNMDNkN3RDSmdjM0pxcmdCYXBXRVpoeHFrUFFCM0NDMW4xa0loR29pQjk1?=
 =?utf-8?B?dk9mQWFtR3lSdGVsNEVmMlJ2TmNYTG4wSzVZNEZqZ3NjUmVPKzFCU2dEUFBy?=
 =?utf-8?B?RFJLVTFrL1VHN0RERFFzTnUxVCsyajM2aFh1cTJaQ1B6Y0dYa3RiZGVqbWp6?=
 =?utf-8?B?aTdVTlZTZkYrV2xDRVREZjNHdGpaZnVVRlplYmlZQkJJQmNzMFZaNkJ4MllM?=
 =?utf-8?B?bFYyT1YyRzd2QXJIaGg4Z2JXOHpVU2lWWFk3NUtsVUNUbFhmbjFSTHlhcE82?=
 =?utf-8?B?MmhDMkErekZ1RVdqbnRCa0RGS3ZCc2FSUnQrSE94Y3FFVS9ydW5yY3BWWkFZ?=
 =?utf-8?B?K2l6S2ptdDAvQXVqaWRFR1Y1QjEralRQRXIxOW1LSUtpS0RscFZmTlIyK2xW?=
 =?utf-8?B?ZldELzFPc283YTVuM2lYdWRvWHcyQmIrU3Fjem5ScVV6U0J2eUlST2VxNHlq?=
 =?utf-8?B?S2NiRlJhT1RvM2NXSDh1NkJZY3VVYmV0TWlpMXNZeFNkaFQ3c2xjYlNCcEJv?=
 =?utf-8?B?RHNSaDVkZmYxaitsc2lUY3FhSnB3TEVMM1pOT3EvaW5LK3lWdi8wVjFpREdE?=
 =?utf-8?B?MWt5TEdRZG9GbHUzaWZZVW5DTUFpVFFNcFhKeE5Bbm9Ta3BSbXdOanNIZzMx?=
 =?utf-8?B?bkJZdk5DeEExQU5UNlN3VlhPaWw4MkhuOW9ZN3ptM0gyYkdaVkorTFV2QkJJ?=
 =?utf-8?B?VkVFcVVnR3lTK0ZDWklzakliQ2g0L29Cc3BGWlp3Zk41YS9pYmpHZFdrOTRF?=
 =?utf-8?B?NjByMTMwUWNGKy9HTm5jR3F0aW5FeVdLNkFBUjNjMHVLR1ZqREREWFdjRXBT?=
 =?utf-8?B?K2MxaGw2SjdTU0FoVnU5SXMzR2FCMllHc3Z1OTJYN29JWUluSzArNmkydFVP?=
 =?utf-8?B?TFpXZGdCWGFOS0U0OStWVVlNQlZQRWJDd3d0LzRTTW1mMHpWQ0lzWkVjNVhI?=
 =?utf-8?B?bnNoN3kwcEdNVGtYaFEyWDlwUWszQTkvV3YrV3k1bEJHdlFJZGI3NUpsUGhB?=
 =?utf-8?B?SWRSQzBsN2RVVDdRcjMxK3E2SVQ3T2laTEhvMG9QNHFPNmUzUXYvemluS0lK?=
 =?utf-8?B?ZGhZaHh3Tkh1NzcxYm9aK3p4OVFSN2U5d3R2TUNsL2hLVzVobmdPd1R1QjBz?=
 =?utf-8?Q?AJsSAC02dSfpa6AYKd9gmOk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65654750-3101-419a-7847-08d9dc292098
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 15:25:45.0468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0oi2aSakybdC6b83E3hirloFEb3vanVHksLJzyG3ayjuKBRoW7F3UJd4VzQ/2+lfg6C5T37DgcuODg0P20KvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5468
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no point in disabling x2APIC mode when running as a Xen HVM
guest, just enable it when available.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/xen/enlighten_hvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 42300941ec29..ab8171cbee23 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -9,6 +9,7 @@
 #include <xen/events.h>
 #include <xen/interface/memory.h>
 
+#include <asm/apic.h>
 #include <asm/cpu.h>
 #include <asm/smp.h>
 #include <asm/io_apic.h>
@@ -248,7 +249,7 @@ bool __init xen_hvm_need_lapic(void)
 		return false;
 	if (!xen_hvm_domain())
 		return false;
-	if (xen_feature(XENFEAT_hvm_pirqs) && xen_have_vector_callback)
+	if (!x2apic_supported())
 		return false;
 	return true;
 }
-- 
2.34.1

