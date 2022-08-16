Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F89595EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbiHPPZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiHPPY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:24:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D8086718
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:24:07 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GDd8eZ032471;
        Tue, 16 Aug 2022 15:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=orXFR3oS3IOKl3LmWr8VEnc1TVb07XDSC2QWu/ZdZt0=;
 b=jhlzoVVRI1gBA6FuHYjAyL7OnRH0WWCuQuQ1e40Lz8UX+mIAevIHqHkxjuKqu8TUEAkb
 61wX6KRlwNiz8e0FTnejF6gI8F0mPivpPNLtjY2JKeliIlqjWGjShEj6ajWltROz/kZZ
 rIcmtGjcFJlh/u67hxiozEuoHrES3kS2fAafxQ8Hqy1hqqfyLzj9YOxMv+8z/mc9sOIv
 otANawL16e4ZhPzL88tri/3PV7ipBveAE3cRqJJu0oRs9ZCwfGiqF0rw11CKm9unMG4M
 7/obX3iWk4Kzz3OCbLO1I0Cls2bY1I4FcJYUzIho93mbzKRMraFqlzlLTwITFd3wxa1f vg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx2ccp88q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 15:23:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27GDUjfU004882;
        Tue, 16 Aug 2022 15:23:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c6cbeea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 15:23:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij7U1O9V8hK5+zzvQ/4m8i+gPDZNMAuMYg9QLHWROXWn5vQZq1MpLrXkus8KjWBnxmpnzdAmAQWlw2fMC3XhQHOFUI7RiImwdjTc2e/JsgbP1uTDt2hkZfCVl9OSvAXJwsn+tz94ObAToYgFUQkJ6U/IYb6MbOXhptHWlAljVm4Q0ArBJ2lHW3xveHxUbDbQsqpjv065frAGfBrQf6io38ahXHYfEpkqiune/vTftLsqJysuRcRCT5XHiYApdBPswD8SU3AZtyfIoLNelJ4XyWs/RQ8V1cBGa65XUQipaXS+7k116Mt2HOjslVqpiQJ5syf0Gue6RErxfOmzXGrVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orXFR3oS3IOKl3LmWr8VEnc1TVb07XDSC2QWu/ZdZt0=;
 b=n+AL0jGViWFmGy5NA1hYZ9jGsznPfhgWpMncJ8Dixqz6k/L02jZ13lqoPLi3+L6Ld5RjBQVRe/s4AhfmqD+2V7bd/dDaih0R6spCXOK52cp/nr86gg40i4Zos7MjCBHgMWYTlcPu9t4r+/rNlFRdsxE8Jy8O5MiDg6R68kJrQzRJ3BA7OHjKoP8Bs0f2uSNbNviybWFzImKYD5Hk4TXKFTZgAAu0D+6+XPDlDuuwer9e/Czt9QQ21s4675R5peH0JUIvZDVDHhlch1FfeMY35yXZJrNfi/lx1KVYVBS8S5bK0sw7Y3d68k7iGDiPl3MlPvqMQ/waM4fsCuzXA/wcog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orXFR3oS3IOKl3LmWr8VEnc1TVb07XDSC2QWu/ZdZt0=;
 b=cAjGwW7c8Se/2XG9oXNah4BJ9ZGrY7IlQyOT3Tdn11UH+QMAbgzrS5Nye0NQtXb9ItDY8OhxfpZWQjGuWXoI0a1MVu8Wao7v/Nqlh4/mSsqnypC6FOX58nQSUhCKih/24CkvMiUzMvoodvtQXkTRSagEM3RAFFyb50/W8h8DPtQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY5PR10MB6022.namprd10.prod.outlook.com (2603:10b6:930:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Tue, 16 Aug
 2022 15:23:22 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2%9]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 15:23:22 +0000
Message-ID: <0395a745-edbb-275a-f37f-c6e799388da1@oracle.com>
Date:   Tue, 16 Aug 2022 10:23:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v10 8/8] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220721181747.1640-1-eric.devolder@oracle.com>
 <20220721181747.1640-9-eric.devolder@oracle.com>
 <Yvbxgvk+5HqEl7J2@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Yvbxgvk+5HqEl7J2@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0061.namprd06.prod.outlook.com
 (2603:10b6:5:54::38) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05905291-deb5-41b9-8bb1-08da7f9b4159
X-MS-TrafficTypeDiagnostic: CY5PR10MB6022:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w7f7vahA97qlW+2RnOck1vA/MROPHqMfeh32/KLZsodwZQwTpa6eppXPZTzYt0f7/2fepk+zP1nD+aj/9qb7F5I1P63yzeM/uADnwaVbh2SJBqH9+9qwwQDM0KGMWUZSubOBDrQOw08ZxmWkJm5ktgZQ0/qXGtmWTWbqe24GG6Hwvab5Mymj+bVbYGaJMcYy/SdBJCDc5lRNk1wv3ymPRSDNplazWT/xCFfP+Bc740t71I2XV7RFnyoPqFszlYSlTrb/SkYvxKX9DACqU6G7hOpOz8KCRwvk/EzKqpBBDrVAwpju49tcFxc/fujnystQcZTnR+Xjsk5qOIbCHt2gABYFHllqMcvouBBQsGz0AcQaUsR8qFAZ1vsAYa+EWb4VBM0FJhS9DuVTHtXcx2zj5UKLYpkI1yk2ES+fojpLizKy5bZn68uNw+UUxdq/AiEKGgRPA/dRQKBTjZH6Rut2mbMF2GMkcFOeT6kcQ+AUSrsMLA/GNq+XavttybpX8Q/krJh3cqTsHwPi36n9M54uGzGM7cIj4Gm7sxY3G1P9U+wuIzahdUjgjjUss2f4QSG2qV+2LfoH+SvTnxiCjudTZuI74hnX5/CcUgmAFhWVYZ0A+U3QsyCxIzuSeMx6QTzBR/CjZQMf9tLCKlKAAyTztZMNtenCOm27ya7L4vhOK19frhZjHPfi0lke4zEwxiu1Ywxc30qS4L8eq5JdZAfpnRDrWZrhCRSCr3019QSIlzEBleqhpS3H4hV9i5Phlwcmmax57dpil4rvFF6Tk2XFO5aWZLxD/6Ltg1tSrljyHQH1x2gMd7+UCTLNbPX/AA0hHH3oqH/aZUDtXGXJvCB8xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(376002)(396003)(39860400002)(346002)(31686004)(7416002)(5660300002)(36756003)(66946007)(66556008)(66476007)(6916009)(316002)(2906002)(86362001)(31696002)(83380400001)(6666004)(8676002)(6512007)(6506007)(6486002)(38100700002)(478600001)(53546011)(4326008)(8936002)(107886003)(2616005)(186003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUFPM3NhTlNOSFhnMW4vdVJPVFZlRTcrOGZFK2NuY2xXL1dPYjR3VHZxTUlR?=
 =?utf-8?B?RSs2SGx5OUVwejZEYkR1VjNKNDQ1VEVmaFk5MjJKV1pBd2Rvem1zZjZUcWEy?=
 =?utf-8?B?NE9HQnY1M09XSlFBNkR3eVp5MmxQVGRkcVNRUVlVeWNHbjZsWGRSK3Nka0V4?=
 =?utf-8?B?Nk1TQnU5NnRrZHNpalN3d3AyeFBna09vaEJ1U2VkcHpZM3lqc3JoQ0xCVVVR?=
 =?utf-8?B?WjBlRXQrQXJwRTl3Z3NkSmhjUmV1c0Q5Zm8rSDdrc3NHdFoxemU2Wkc2UG9z?=
 =?utf-8?B?ZmRRRit3MW5YUU1rREZJNmpXaXhYZXJwRVRsM0tYOTU1MEF1RngwY3RkRk5C?=
 =?utf-8?B?cW9QNzJFU1dzZHg5ektlQlZDMWRoVlJ4VU01LzZIMHBuZU1vU2d2SnFKQ2M3?=
 =?utf-8?B?R24zUzBGaHg5U2s3eWp4Yy9LUnhqTjZGM2oybC9PU3F5K2hLZ1FNcjgxWXFz?=
 =?utf-8?B?aWs5UWFydjdyRE1ZL2ZUZ0xReldESThPWkZYV3FHR1RLWEJMZ3hpN04wN09a?=
 =?utf-8?B?NWpPSzhmaS9jdHEyYkpScHI5YzBQMXRscFc1UzJGUFZmVE56c3FKQ0RjUFBx?=
 =?utf-8?B?Snc4eXVNNXI4TzlTNmtMMlVxVXdzeVl3dEF0Rm82S0wwdjVsT3ZNaWVadG9I?=
 =?utf-8?B?ODI2WldoME1DL2RTNVRPK2VoWGdacGliVlRMRG1uNVlJYzJUNjlGYlhiaFJR?=
 =?utf-8?B?cXh6OHVEUkk3NTllUUlQRzBVaXJQM3hLOWs1bmtYc1cxdmp2V3cvd3VBMkt0?=
 =?utf-8?B?OFFjT1hRTFlwcTZLN3FsdjhuelFaUW1pNENtRDUzTXRoOElKQjlWdnJDbEpN?=
 =?utf-8?B?YU13YUlZa2duRkduUE1JL1FXeUdadmFZa0R0aXovcWFBcldvOFVkNVVyUlV1?=
 =?utf-8?B?VEJVcGR3bnVNVDNBNjA3S1FidlBaQis5V2o1NkV4QmxGYWJYQ0hTSzc4VmRC?=
 =?utf-8?B?dTZYdTlucXQ1MFVLTDJVMXduZzEvRFFKYkZzdE9XZ1lkcVZOUWpJN0lpL2dC?=
 =?utf-8?B?MUFZWCtTdDB2MDdKSUJ1U2hueGU3Qzg5ZU81TnRNeHlzMXFPRW1vdVJ0bmhs?=
 =?utf-8?B?dTVZR3BobE8wVXorOFR3MDZGM2paT1BHbDVSeE9UQXpNV0w3U3VmbHJ2elI2?=
 =?utf-8?B?TkVFdUNMaDJXSlFMQXpVSVRqU3pMTU9DYnpVR2pJaDREK3RlU3VrL3RHcENj?=
 =?utf-8?B?SFdpZXpkRHRzam9UdW1tNmxGTEUxS3l3YVlBN0o4enpOQ1pyeHQ4WThLb1Mw?=
 =?utf-8?B?RWVEZmxzOCtFMEEwQmNDNnpLUmRZU04zcFdEbzhNbjFPdUdGVTNGUFVtaUx6?=
 =?utf-8?B?czFtZE1pOXFEU3ljeGtsbWVuUVhRVVBRSkxpWVpuN1o3ZGZQMy91RnV1NEJF?=
 =?utf-8?B?UzBPbjZDdG00dll5bVRuWUtlL0ZzOCtubE1Ddk8xa3dzQ3BxN2o0YnBXcjJF?=
 =?utf-8?B?WTl6SGdLVFd2QjFGaEtRVVppTXpxVDMzRFBSNW4vT241T1oxZ2pIRHF1L0FE?=
 =?utf-8?B?R2F5YStyZUpNUnpCRUxaYzlENVd4czd2ck1IS3dCTUlFb0wzc0xzeFpoTnZ0?=
 =?utf-8?B?OHZrckpCQm55aGdraGhXRm9tWXJBdTVaRnJ1UERXM2hzVC9rTmlCRVdMS3Vy?=
 =?utf-8?B?dmNYaUp1YWZUQVRtT0ZLQnlXc21lM2VraForWEVSL0djTkJWNVFLQi9xeUFt?=
 =?utf-8?B?SFM2ZVRQZjBUaWhkcllERnYyNnRoWU4yc1gwQWJTUmtMRGRGRklPSGNjLzRV?=
 =?utf-8?B?MnJ1ZlhNdHhjZktHcmxSL1oxTFhYSVJKL0VnSFk0VFl3c0FYRkpaSlo2RDda?=
 =?utf-8?B?cFdiL3BHb1RaSDlKWFlBc0hYVFFYeVEvYTJyemN3MXBTWjJyU0VJYmdVVmFX?=
 =?utf-8?B?dGpGaHFZOXVhMFM4NzdEb25XOUhBcHEyZWY5aHR3Vm8vZGVHYklnR1h2MjhB?=
 =?utf-8?B?SmhQRk40dkJnZ1NmV0xKVEpFa0dsY0ttQ3k3a2RBS2FLaitQRnRHYkpTczJN?=
 =?utf-8?B?OHJKMzErUWFDbUpkY29VMUdiZVN1UTZPdGpJZGNPeTllSmVvVm9CcWFhVGpJ?=
 =?utf-8?B?N0dKY3h2bEpENnVYRVdQREYzUUxxZ0hIbmgxblh0b0xUQndaaTdLQjFISFpn?=
 =?utf-8?B?WEtZSU9BeFlGcGVkc2pOR1dtelFCWW5icityWXNnNXBSZ2pDbysvMXd4R3Bi?=
 =?utf-8?Q?dLq2/GTyA2cPdE9uaQVk4s4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cHg4MXdnUnRmYjZQSXdMY3liTXcycXNvZGUwY3ZZdll2TzIxemxKeExySmlZ?=
 =?utf-8?B?T092dVNCV3hESlVXc2llb0xvY3lQRk5wU2UwaUZJU0RNdHhISkhLVFNpUHIw?=
 =?utf-8?B?R2RlVUlvbXViT1laalduNUlra240Um9TbEdkeHprU0FDT3lnTlNvcDRlR1Bi?=
 =?utf-8?B?ZG5XbTdBT1d6RUJrMFhjZm9BTXhadzNPQVk1NHV1alE2QXVDSy9TWmFFa2pR?=
 =?utf-8?B?b2xPcStwNGN4M25sb3MvSFA4a1g4SjJBeGQ0aHhCajd4eWNwYWUrWG12T05w?=
 =?utf-8?B?eHVGM1c5U0MwajJVeWIwbGJJZk5SUytZczFXMTNYRGZrWHlCRFkyZ2N2bkFw?=
 =?utf-8?B?aGwxQ0cxQ2VyQkZmcTI4eFdxOXhRS3VXNHJZSy9tYkZjZ3hSVHUvRmlPYXlR?=
 =?utf-8?B?cDdzN1pZS0hwVERzOVRRb01oTUFQYVNFNDFIMU1Wellubko4amxaMjZRUitH?=
 =?utf-8?B?ZVRVNHJmOTRQM2RhRkN4OXozanFWVmFUdEJJTkdoaG1qbjdZWHdSYmJ6MlNy?=
 =?utf-8?B?UytqTWNWanRSMExSYnhZY1pNU2lLSC84S2ZraE1tYUlFVXFFdWo2c29KNmkx?=
 =?utf-8?B?NHp3aWdudVlEWFg5a2pkZnZWcnBiOFBBSlZwVDQrT1F4Ri81akNZQnBqYXFV?=
 =?utf-8?B?MndWSE0vbmhFOXRTMmNBYTVRZjJYTTR1c0s1MGJrdEdqMCsvWkUyNmVCUjFK?=
 =?utf-8?B?RkZDRC9hT0Z0a2N4VThJdHVUd1MxbWpCRnc2N3c4TlFqdjhPakQ3K3g0VUYy?=
 =?utf-8?B?OHZseXI5YzVtUEFGYmUrNWU0UlNCWmw3OENHallvdXlVTTV5b1BLODZRZ2FL?=
 =?utf-8?B?K1V0OGV2K1UyTThPdHpMSXRCa1AwQ2RLWjJDOW4yZGlkZmVwSFVzTFFYZ1JR?=
 =?utf-8?B?cEVjSGhRVHo3bGkwYjdvMHpIeDZxWWhjaFlJTW9XejRLL0JuK3BWa04wV0E2?=
 =?utf-8?B?TTJiQkM4Wk9IVUc5c2xxMmhLZlFUaGJHZkcrZTVpM2lsN25KcmI0ZEJRV0or?=
 =?utf-8?B?QUY3dG5VR1YxV0F1Z0gvc21LTUpINGpWVm9sdlFCcU84ZFFRVVJ6K2t1MWI5?=
 =?utf-8?B?M0JFQ3hVcU5vRTZsb053dytvcTNBQ3J2aWtaSHJKc3hZS3B5VVhITFIrT05i?=
 =?utf-8?B?Z3Q3ZTlvL3o2dWtZeUJIb3lsaHE3cnZJUnBEQWlTS0tKbDVHRVhXTitrTlg5?=
 =?utf-8?B?S3MraXZyZnJWamMrd05GRGtIRERNcEkwRXA5QW5iMHZGK1VrbEZLS3FPRmdX?=
 =?utf-8?B?cHBmZkZaSGIvYU9vZHFEcFhGc2pzS2JXWWZZbnRLa0xWY1BTbjRjbk9zS1hV?=
 =?utf-8?B?MDVzNzl5UENJaFNrODBvekQvMW40OW1rYUo1U2k4YU1PR3ZLMUxxOW9qeTVy?=
 =?utf-8?B?eHpUOUFZN2FrQWdpVG1Wek9Nc0gzaHBZc0tOaHVVYTJyWU02cS83alRISkd2?=
 =?utf-8?B?QURQcldZazJuN3U3NWNKRElHSlI0Mmh0eTdYMWowOEh2OC9yeEcwdmpsdzlv?=
 =?utf-8?B?SXhsWFFiRmI2NEQ2MmZwNkp1Nmd5SHlTV2dmakNZc0NadVJDUHZrNnFLVGhW?=
 =?utf-8?B?UWJBY0dsYjRKSjZwRENpRkxwNys3YjdYZlBTc1Z4QWJ4ODVMUFdDVWRySExx?=
 =?utf-8?B?YVkyKzRoL2M3bDNIVWRUT2RlRmlZODZmTHlzYjNPMlRQaWs2UFZpOVNRdjhI?=
 =?utf-8?B?YktBOVZaWloyamIzMmVRUHhVeWRSMGFBWERBenlLZmV5cHk3eVRuQ3dEUzMz?=
 =?utf-8?B?dE5NNllIVHMrSjZHWW1iVlBhMXNJWmxMZkU0enNubFdnb0RvUlFOdmFpWHVy?=
 =?utf-8?B?UHpyelVHd1V3a0FwVm1ZWG9Xcm1MNGZDZXNXeVZSZGREQWdDZ3g3RUtuRnJI?=
 =?utf-8?B?SU9ySU1tbzREUU5xQ3Nzb0JEZVN1S2tGY0dMT0JncGd2VkxlQWxkV3dydXdM?=
 =?utf-8?B?M0RDdUduaVFpZzZtM0lMQ1Zrc3l5NlFZZHc4UkY1NVE3aHEyMnhHZzdaSXRz?=
 =?utf-8?B?Z2hqay84YkVPeHR2bm44Z0dhc2FNNEpTdTlwQkNOaHpNdjdVNEFnQmFWaElo?=
 =?utf-8?B?RWxjK1RDaUJYR3pQb21xQjE1b3d5aTMwRjN3bVg5bWFNcjMya3ovdjRtSEtU?=
 =?utf-8?B?UzJDbUo5aSt4SDRBV1FITmUxZGxtVFAwVHlydFVtYkQ4c1drRWFobUFuZS8w?=
 =?utf-8?Q?nQV40ZZAc9bGcC6xG8IbmxZMhV20nob5na7Bil0k0gd3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05905291-deb5-41b9-8bb1-08da7f9b4159
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 15:23:22.1267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCJhKSMoYzUmyLB8fDpTNw0Rizg2YvaFNBXnpTShMMF/ZWBQk3J9S1CkB58BSqqZN3yA1RZM084fmTQLzLUGld8l9vBimG5OLrMpiAedcz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6022
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160059
X-Proofpoint-GUID: _K0w2CKXi7Gb_U5COQAoFSP0TBG88bLB
X-Proofpoint-ORIG-GUID: _K0w2CKXi7Gb_U5COQAoFSP0TBG88bLB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/22 19:34, Baoquan He wrote:
> On 07/21/22 at 02:17pm, Eric DeVolder wrote:
> ...snip....
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index e58798f636d4..bb59596c8bea 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2065,6 +2065,17 @@ config CRASH_DUMP
>>   	  (CONFIG_RELOCATABLE=y).
>>   	  For more details see Documentation/admin-guide/kdump/kdump.rst
>>   
>> +config CRASH_MAX_MEMORY_RANGES
>> +	depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
>> +	int
>> +	default 32768
> 
> Do we need to enforce the value with page align and minimal size? I

Are you asking about the value CRASH_MAX_MEMORY_RANGES? This value represents
the maximum number of memory ranges, and there Elf64_Phdrs, that we need to
allow for elfcorehdr memory. So I'm not sure what the concern for alignment
is. I suppose we could also institute a minimum size for this value, say 1024.

> checked crash_load_segments() in arch/x86/kernel/crash.c, it does the
> page size aligning in kexec_add_buffer(). And in
> load_crashdump_segments() of
> kexec-tools/kexec/arch/i386/crashdump-x86.c, it creates elfcorehdr at
> below code, the align is 1024, and in generic add_buffer()
> implementation, it enforces the memsz page aligned, and changes the
> passed align as page alignment.
> 
> 
> 	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
>                                                          max_addr, -1);
> 
> Maybe we should at least mention this in the help text to notice people.

Unfortunately I do not yet understand the concern being raised.

> 
>> +	help
>> +	  For the kexec_file_load path, specify the maximum number of
>> +	  memory regions, eg. as represented by the 'System RAM' entries
>> +	  in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
>> +	  This value is combined with NR_CPUS and multiplied by Elf64_Phdr
>> +	  size to determine the final buffer size.
>> +
>>   config KEXEC_JUMP
>>   	bool "kexec jump"
>>   	depends on KEXEC && HIBERNATION
>> diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
>> index 8b6bd63530dc..96051d8e4b45 100644
>> --- a/arch/x86/include/asm/crash.h
>> +++ b/arch/x86/include/asm/crash.h
>> @@ -9,4 +9,24 @@ int crash_setup_memmap_entries(struct kimage *image,
>>   		struct boot_params *params);
>>   void crash_smp_send_stop(void);
>>   
>> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size);
>> +#define arch_map_crash_pages arch_map_crash_pages
>> +
>> +void arch_unmap_crash_pages(void **ptr);
>> +#define arch_unmap_crash_pages arch_unmap_crash_pages
>> +
>> +void arch_crash_handle_hotplug_event(struct kimage *image,
>> +		unsigned int hp_action, unsigned int cpu);
>> +#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
>> +
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +static inline int crash_hotplug_cpu_support(void) { return 1; }
>> +#define crash_hotplug_cpu_support crash_hotplug_cpu_support
>> +#endif
>> +
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +static inline int crash_hotplug_memory_support(void) { return 1; }
>> +#define crash_hotplug_memory_support crash_hotplug_memory_support
>> +#endif
>> +
>>   #endif /* _ASM_X86_CRASH_H */
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 9ceb93c176a6..55dda4fcde6e 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/memblock.h>
>> +#include <linux/highmem.h>
>>   
>>   #include <asm/processor.h>
>>   #include <asm/hardirq.h>
>> @@ -397,7 +398,17 @@ int crash_load_segments(struct kimage *image)
>>   	image->elf_headers = kbuf.buffer;
>>   	image->elf_headers_sz = kbuf.bufsz;
>>   
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
>> +	kbuf.memsz = (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
> 
> Do we need to break the line to 80 chars?

Sure, I will do so.

> 
>> +	/* For marking as usable to crash kernel */
>> +	image->elf_headers_sz = kbuf.memsz;
> 
> Do we need this code comment?

Well, it did take me a while to figure this particular item out in order for all
this code to work right (else the crash kernel would fail at boot time). So I
think it best to keep this comment.

> 
>> +	/* Record the index of the elfcorehdr segment */
>> +	image->elfcorehdr_index = image->nr_segments;
> 
> And this place?

Not necessarily needed, but I've found it useful.

> 
>> +	image->elfcorehdr_index_valid = true;
>> +#else
>>   	kbuf.memsz = kbuf.bufsz;
>> +#endif
>>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>   	ret = kexec_add_buffer(&kbuf);
>> @@ -412,3 +423,107 @@ int crash_load_segments(struct kimage *image)
>>   	return ret;
>>   }
>>   #endif /* CONFIG_KEXEC_FILE */
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
>> +{
>> +	/*
>> +	 * NOTE: The addresses and sizes passed to this routine have
>> +	 * already been fully aligned on page boundaries. There is no
>> +	 * need for massaging the address or size.
>> +	 */
> 
> Can we move the code comment above function interface?

Yes

> 
>> +	void *ptr = NULL;
>> +
>> +	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
> 
> Do we need this code comment? On ARCH where proctionion is made, we
> surely need to the protect/unprotect.

I will remove this; I've mentioned this in handle_hotplug_event() where these
protect/unprotect functions are called.

> 
>> +	if (size > 0) {
>> +		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
>> +
>> +		ptr = kmap_local_page(page);
>> +	}
>> +
>> +	return ptr;
>> +}
>> +
>> +void arch_unmap_crash_pages(void **ptr)
>> +{
>> +	if (ptr) {
>> +		if (*ptr)
>> +			kunmap_local(*ptr);
>> +		*ptr = NULL;
>> +	}
>> +}
>> +
>> +/**
>> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>> + * @image: the active struct kimage
>> + * @hp_action: the hot un/plug action being handled
>> + * @cpu: when KEXEC_CRASH_HP_ADD/REMOVE_CPU, the cpu affected
>> + *
>> + * To accurately reflect hot un/plug changes, the elfcorehdr (which
>> + * is passed to the crash kernel via the elfcorehdr= parameter)
>> + * must be updated with the new list of CPUs and memories. The new
>> + * elfcorehdr is prepared in a kernel buffer, and then it is
>> + * written on top of the existing/old elfcorehdr.
>> + *
>> + * For hotplug changes to elfcorehdr to work, two conditions are
>> + * needed:
>> + * First, the segment containing the elfcorehdr must be large enough
>> + * to permit a growing number of resources. See the
>> + * CONFIG_CRASH_MAX_MEMORY_RANGES description.
>> + * Second, purgatory must explicitly exclude the elfcorehdr from the
>> + * list of segments it checks (since the elfcorehdr changes and thus
>> + * would require an update to purgatory itself to update the digest).
> 
> Isn't this generic concept to crash hotplug? Should we move it out to
> some generic place?

Yes, so I will relocate this.

> 
>> + *
>> + */
>> +void arch_crash_handle_hotplug_event(struct kimage *image,
>> +	unsigned int hp_action, unsigned int cpu)
> 
> The passed in 'cpu' is not used at all, what is it added for? I didn't
> see explanation about it.

Well its not used for x86, but as I recall, Sourabh Jain needed it for the PowerPC handler.

> 
>> +{
>> +	struct kexec_segment *ksegment;
>> +	unsigned char *ptr = NULL;
>> +	unsigned long elfsz = 0;
>> +	void *elfbuf = NULL;
>> +	unsigned long mem, memsz;
>> +
>> +	/*
>> +	 * Elfcorehdr_index_valid checked in crash_core:handle_hotplug_event()
>> +	 */
>> +	ksegment = &image->segment[image->elfcorehdr_index];
>> +	mem = ksegment->mem;
>> +	memsz = ksegment->memsz;
>> +
>> +	/*
>> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>> +	 * memory resources.
>> +	 */
>> +	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
>> +		pr_err("crash hp: unable to prepare elfcore headers");
>> +		goto out;
>> +	}
>> +	if (elfsz > memsz) {
>> +		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
>> +			elfsz, memsz);
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * At this point, we are all but assured of success.
>> +	 * Copy new elfcorehdr into destination.
>> +	 */
>> +	ptr = arch_map_crash_pages(mem, memsz);
>> +	if (ptr) {
>> +		/*
>> +		 * Temporarily invalidate the crash image while the
>> +		 * elfcorehdr is updated.
>> +		 */
>> +		xchg(&kexec_crash_image, NULL);
>> +		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
>> +		xchg(&kexec_crash_image, image);
>> +	}
>> +	arch_unmap_crash_pages((void **)&ptr);
>> +	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
>> +
>> +out:
>> +	if (elfbuf)
>> +		vfree(elfbuf);
>> +}
>> +#endif
>> -- 
>> 2.31.1
>>
> 
