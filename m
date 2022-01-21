Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F63495C77
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379632AbiAUJCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:02:25 -0500
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:12594 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiAUJCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1642755735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=xruKqgasY5HYaX+rO9KYoyn+hj/hj/XhJdIt7oNO8ic=;
  b=YgrSKAnDKQQe+PvdLAJZnAryo6uepHqMsQE9v5GXKvK7nipbzdXFdRaw
   8hMR/sYKTizOtAIQ0/WJD4F3lZo7vvnbhXM7P9rT0KcwHEb0Z38YLiobH
   gJcnAjYX6LxQITq37JGOKsgeW1lLYcqeL2wMPiDYUerCRyjvzY6lL9Oep
   o=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: fBInysA/FVwYQQCmFSCWLlFHoNkk9xL196/yasiI2Sj0XEi8xKKVyZDbYciDhuUqdG0eCpxhI8
 /ZWpV5mNcbfFKxVTiu8+EguBHrzYE4Or6CTaMmSJqdB1/709CjXeIEQ27SYvVpWGpzB3H8uSOi
 zLYfD9hS9WzPjhZ9cOhdB/0GQHA7reVX5p0/XBDu/JUvgkpqbQ02431CxDISfisVXKUfv16R20
 uS0Ie6vs6Mxzxbyo0WNQq408KT4gR4sNA7v1LJCF0qr/UZ4jTbkVTohQrctJ6mfsfhoIe0W5E7
 7ssj2k0P1QrSUu0NzwakydE3
X-SBRS: 5.2
X-MesageID: 64629217
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:ILqOu6OcDYeJIBzvrR25kcFynXyQoLVcMsEvi/4bfWQNrUoh32YHy
 WcZDz/UP/qCZ2XxeNslOYW3/EwEvp7WzNI2TQto+SlhQUwRpJueD7x1DKtR0wB+jCHnZBg6h
 ynLQoCYdKjYdpJYz/uUGuCJQUNUjMlkfZKhTr6UUsxNbVU8En150Eg6w7dRbrNA2rBVPSvc4
 bsenOWHULOV82Yc3rU8sv/rRLtH5ZweiRtA1rAMTakjUGz2zhH5OKk3N6CpR0YUd6EPdgKMq
 0Qv+5nilo/R109F5tpICd8XeGVSKlLZFVDmZna7x8FOK/WNz8A/+v9TCRYSVatYoy3Wg4t62
 dJGjt+pTyExN6CWxtssVAYNRkmSPYUekFPGCX22sMjVxEzaaXr8hf5pCSnaP6VBpLwxWzsXs
 6VFdnZdNXhvhMrvqF6/YvNrick5atHiIasUu216zCGfBvEjKXzGa/uWu4UJhm5v7ixINdfwO
 +YUbzBkViSaU0JrMU0LELc/nPj90xETdBUH8QnI9MLb+VP7wAVv3f7tOdzOd9qiQcRTg1bep
 2Ta8mC/CRYfXPSV0RKM9nOhgL+JkS6TcJJCSpW7++RsjVnVwXYcYDUGWF3+rfSnh0qWX9NEN
 1dS6icotbI19kGgUp/6RRLQiH6ctzYOSsZXCasx7wTl4q/V5QmeLnIJQj5IdJots8pebTYtz
 F6S2dTyGSZorqaWWFqa7L6fqT70Mi8QRUcGZCkZXU4G7sPlrYUbkB3CVJBgHbSzg9mzHiv/q
 xiIozI5nK47ltMQ2uOw+lWvqy6joojhSg8z+xnNWWSk/kV1aeaNfJe04FLW6fJBKoexTVSbu
 nUA3c+E44gz4YqlzXLXBr9XRffwuqjDYGa0bUNT84cJ72uxoHWyeotroyh4Al9gP5xaRg7uf
 xqG0e9O36N7MHyvZK5xRou+DcU20KTtfejYuuDogslmOcYoKlLelM16TQvJhj22zhBw+U0qE
 c7DKZ7EMJoMNUhwINNarc852KRj+C0xzHi7qXvTn0X+iur2iJJ4pN443LqyggIRsfvsTOb9q
 Y832y62J/N3CryWjs7/q997ELzyBSJnba0aUuQOHgJ5HiJoGXs6F9jayq47dopuksx9z7mUp
 C7lAR4JkQah3RUrzDlmjFg4MNsDur4k9RoG0dEEZw70ixDPn67yhEvgS3fHVeZ+r7EypRKFZ
 /IEZ9+BEpxypsfvoFwggW3GhNU6LnyD3FvWVwL8OWRXV8M+G2Thp4G1FiOypHhmJnfm7qMW/
 uz/vj43tLJeHWyO+u6MNqL2p75w1FBA8N9Ps7zge4kKJx60odE0ckQcTJYfeqkxFPkK/RPDv
 y6+ChYEv+jd5Ygz9djCn6efqIm1VeB5GyJn86PztOze2fDy8jXxzIlefvyPeDyBBmr49L/7P
 bdezu3mMe1Bl1FP6tIuH7FuxKM4xt3uu74FkVg0QCSVNwymWuF6P32L/chTrakRlLVXjhS7B
 xCU8d5ANLTXZM68SAwNJBAoZ/io3O0PnmWA9uw8JUj3vXcl/LeOXUhIEQOLjShRcOl8PI8/m
 L9zs88K8Q2vzBEtN4/e3CxT8m2NKF0GUrkm6c5GUNO61FJzxwgbM5LGCyLw7JWeUPl2MxEnc
 m2Oma7Pp7VA3U6eIXA9ImfAgLhGjpMUtREUkFJbfwaVmsDIj+Mc1QFK9WhlVRxcyxhK3r4hO
 mVvMEEpd6yC8y0x2ZpGVmGoXQpAGAeY6gr6zF5QzD/VSEyhV2rsKmwhOLnSoBBFojwEJjULr
 quFzGvFUCrxeJCj1yQ/bkdptvj/QIEj7QbFgs2mQ5yIEpRSjeAJWUNyib7kcyfaPP4=
IronPort-HdrOrdr: A9a23:xpndpamy0nvCQNLreAVT4YyAf/fpDfO0imdD5ihNYBxZY6Wkfp
 +V88jzhCWZtN9OYhwdcLC7WZVpQRvnhPpICO4qTMuftWjdyRaVxeRZg7cKrAeQfREWmtQtt5
 uINpIOc+EYbmIK/PoSgjPIaurIqePvmMvD5Za8854ud3ARV0gJ1XYGNu/xKDwQeOApP+tdKH
 LKjfA32AZINE5nJfiTNz0gZazuttfLnJXpbVovAAMm0hCHiXeN5KThGxaV8x8CW3cXqI1SvF
 Ttokjc3OGOovu7whjT2yv66IlXosLozp9mCNaXgsYYBz3wgkKDZZhnWZeFoDcpydvfomoCoZ
 3pmVMNLs5z43TeciWcpgbs4RDp1HIU53rr2Taj8A3eiP28YAh/J9tKhIpffBecwVEnpstA3K
 VC2H/cn4ZLDDvb9R6NqeTgZlVPrA6ZsHAimekcgzh0So0FcoJcqoQZ4Qd8DIoAJiTn84oqed
 MeQ/003MwmMW9yUkqp/VWGmLeXLzYO91a9MwQ/U/WuonlrdCsT9Tpc+CQd9k1wg67VBaM0o9
 gsCZ4Y542mePVmGZ6VNN1xMfdfNVa9My4kSFjiWWgPNJt3ck4l+KSHqInc2omRCek1Jd0J6d
 P8bG8=
X-IronPort-AV: E=Sophos;i="5.88,304,1635220800"; 
   d="scan'208";a="64629217"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oB7E2DyHRt4ikf5+v4D1w0NTRVTZs7HLWiFKxj3zW+bWKiaQVn1QFRBpJSD8J/bLHTtxg/3zZWhA8jA2WYeauvdDO1/DAQVGur9iuhPFCuE/oRb4upAA9KH6XDPTm0fgnbdmI4L51+/2O28R+Dx5E9eepw4/tn9snH+P+7NyHaspJFh5qNDTvA6IOXOIN0diLC37F945PSPSV2orotWcxtaHpqSogdU2TefKMbI8rYFVDcd3gCWcQXyuScemffJUt3lVdsq0hI4o92yrLCDA9c/JMBU5WJjd5lrpETR2+lpDSU/C+Zot4RqjC52ywe9/SSSSAq56J4YEKdJWugLo9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GQtCO8m3tAl2RPxHrcI+Aqf67JkTTp2rtnhBaDCS/4=;
 b=gpuNo1drAxVP4ldyJxuIjJjdxcNke+33giF3pK5gPMvk6nJQVpCFd4/5V4b22VoeWmW2kNHoPryoObofjtJUmqWdjK2q8+R61CPBvhdf5j9JhpSDq9FBHQpPTpr5J+pkMIzmlcw4gQY+gAJI/lsqA/E0g5Hz11mR4fm9Y7FkJRNwHrHrvZicULDB/cC3Hm0S7U/lxVE0l4Oy2LmTBVLKJEsmjZlgQDXKw0eCVH+sfgTB904PXTG9S3VqMcpu/G9THi79yQUYl6mCnjaIRCJZooFFeukqbXCbrrc2kSC7dhhKoEAKz3BTbQcAel6sfO71Ai5NBxUnzoBhluaBEOHr1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GQtCO8m3tAl2RPxHrcI+Aqf67JkTTp2rtnhBaDCS/4=;
 b=NWpBw1kmDzTVqfIiXAZQ/Sqj91SVk9cuAlNJewAOz9lWDwLU9DWp31LbuJXd6SVxoc7dObopV3qkmHraiRMXUcR6Rtf9njOOx5i0D7E1h9MdsjJHjvKK39TScHdsJovEXf8kPn9NDld8XlX7o14DFgnTfs283SYo9yqYbxZbbD4=
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
Subject: [PATCH] xen/x2apic: enable x2apic mode when supported for HVM
Date:   Fri, 21 Jan 2022 10:01:46 +0100
Message-ID: <20220121090146.13697-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a34aff19-4530-7f44-c849-4b3eb2aa3d00@oracle.com>
References: <a34aff19-4530-7f44-c849-4b3eb2aa3d00@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR1P264CA0071.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::20) To DS7PR03MB5608.namprd03.prod.outlook.com
 (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0d5230e-7887-4374-c8f6-08d9dcbcb378
X-MS-TrafficTypeDiagnostic: DM6PR03MB4476:EE_
X-Microsoft-Antispam-PRVS: <DM6PR03MB44762360B33C0834813FB4B58F5B9@DM6PR03MB4476.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELqzPaYvxeI7oZylrEJHLDJd89io6oJzZ6H2xqeFzxA2n09Er1i1m2n4PhOCcvNbHxVa3xpuykeWlHBDPh4qLa3XWNpDS+EiCNTSyrJwQaThK/BgXFflU8+19ADp8Izk1V77fZqfOMo3RIvd4tYVTFauIynPRJxJbxMwYtkPoUJOLIDe5wz4A+s18YitVbmsbLwAD3/o0ls7bukOsgFhFEZj7Qu0RYesbQdyz8q4ejkOsGvL/DjVyZMvjMf2aQ8rYM/c3YZczwEMQagEnOF1FP1wBx7cGjst13lNA/xhOP0667gzoLI7WXzLP0BPZ/PC+mWZLCb9LMmkMDyR2PKTR5yoDpC8pl7DXZ9nEMZaMZjHtsJs/wwHWJbt8t7w2uyPwKfNVuk71Wb1ZA1r8cxbypC4jJ6QeLeMxpLl9GQ10YYv//kdzGFlhfR/WopKAH7zSzFKIfXPO3CqW7zI0waWZMqYYjKvjuvFXeSAzA72IcB887vLyjkmWf1af/VAxrX8eUTKmvPqNB4vQt6Xo03Gn9SVdSmQPRETL6BJbSuLUHBZsbuaPyhSB5GKz9GqiVwK994vQf8Cg8gKEdrXOVIzYOOu6QshcU9D+IGZntGQ+PTuyKQWnBUDi1dG5x04VOXf4n6NZE8w0LUWd0c7FP+uNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5608.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6486002)(82960400001)(1076003)(8676002)(38100700002)(7416002)(8936002)(2616005)(86362001)(6506007)(6916009)(36756003)(26005)(54906003)(316002)(4326008)(66946007)(66556008)(66476007)(5660300002)(508600001)(6512007)(186003)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkJpbjlpNVhDTnV6SHdaWERhRy9SR3J0MGh2dGFmeUZSL004ZzVSZFdibEpo?=
 =?utf-8?B?dFhmdlZ6UXdXYlBhSFlnVU44SjhqcDVZS0I2VUFlMEdMSWhiVkZkeXp1U0FN?=
 =?utf-8?B?OG1MeitVZDZPUFFCdHh0d2VNNlhoSzBpbkM1eWlkNjZrU002SXdsMHFvVFFZ?=
 =?utf-8?B?cncyZGpOc2RkYnhWTk5jcUJwVmU5dHkyZWlxZlZZNTNycEpFb3ErNmM5ZlZT?=
 =?utf-8?B?UkhaS2NiWTQ1ZXN2ZkU4dHFjd0J6NzEzZnF6ZUtneEgyYUl4dHFEMEY3dFJH?=
 =?utf-8?B?RzBCaDBwVUhHUU9DZlJmMDRZWEF5U3d5WnFkT0R6QXV6bTVpNEVNVlRkcGhG?=
 =?utf-8?B?d3VPblF3eTVWeHpJNzYvc2pqVlVQY2JjSlN1TUxsTm51QmV2eHRncnZsWS9E?=
 =?utf-8?B?NkRwVkt1VTVudGJ6MlVtMFdwVDFjQkQrSFJhdTAwMlJHdnBZdDZXNzVsZERF?=
 =?utf-8?B?dXd1NllteDNUaURQSG1tMVI0dzRxRG5nTnVLWnN0TjJNUFRkMVoxYzNlVU5U?=
 =?utf-8?B?eWJrcCtkek5FcHJ3dzF6WVJsZUUwVXhYVms5L0ozZmxCZGtEdGgvRWpBYkJH?=
 =?utf-8?B?MlQ5d2YrbnNWVTVKeDJCV1RManBzeE5hZzQrQ1V2MFowOXZJeXFqejhsM1RJ?=
 =?utf-8?B?SDN0bDhTSjgwc1F4TlpsdUl4ZGM3SXBWYUd3c1grZThlTWpSdHpOK1NFcE1P?=
 =?utf-8?B?c2RTZi9sUDNtQmw2TnRTMlpXTWNCZVFNWTJsM0lVQnlidWJsQkx1MVNiakY2?=
 =?utf-8?B?OVZsU0lMNW9KZG5saFhqdVNlS1lFejRtWHFBSjJIeXU3ZWxTRXdZTWxsVm5H?=
 =?utf-8?B?L1FsRkowMTlwemZ0Ylh1S05ndFVHcDZjQ3V6blBUK0s1SEQwVVFhZ0xIS3di?=
 =?utf-8?B?d0hGS3hMd3FUWVo0cW1lQzhYVUdabG5WU1pCb3Fwa0tkY0VycXQ1YjFVU3Fu?=
 =?utf-8?B?ZU90MmN0c09mbXNMTHBoalI3RlVTN1FqRWlIZUpBdXlsWHJ1QUVva1J4b3pV?=
 =?utf-8?B?eFBoNW85d0lpemhGaENRVTg5ckpFSExDY1lWcXR2aG1WaWNQSTFTRXRRQ0Uv?=
 =?utf-8?B?RWhRNFdkL2FMRmt0OEJNdTkyL0ZKUTE1ckhtTjl6Y0NWRmFpTDlEd3V1Qnoz?=
 =?utf-8?B?VGNBRUg4T1V4TUJQaE5BdlZGS3ZCdkZwTHZYVmVrN01wdkZpazROZ0UwR3Er?=
 =?utf-8?B?VDV5YlJtQyt3RWZKVERQNUhGcS9HZFM5NHZ2b1p5b25KaGZnaTViVjB0MW5P?=
 =?utf-8?B?bERmNEhYL1dmS2xzazlnUGZ5QmlpdjdGV1Fjdmk3SG1RZEI4TldsT0haMzFS?=
 =?utf-8?B?cVZmdWsralhTODV6Uzk2aHlyNldHS3pKSHpOSnNFZ3RIdDdMSWxEK2dtcm5M?=
 =?utf-8?B?VnV5VjQwN3NkbmN5ZnB2VkJ0bEJ5cWxHQXlJK3N6NXBZeXdwbUp5WE5xUlZP?=
 =?utf-8?B?TTJqdHF3Tko3akdnZEFjbE1JUkZXN2ZXcnNnS25VczJsZjByU3JvbGdadmxu?=
 =?utf-8?B?Zi9CWE9lc21LZnJFTVRCUkh5SnlvdStjakZYbEs2T3pBNmhwMU1GVXdGQUFw?=
 =?utf-8?B?MlZOWmRZVzZvd0s1bUtTRWd6TDZ1czBSbm5nUkpaRkFmWXY5ZTRLbkJ1WGhw?=
 =?utf-8?B?MXU4RFF4SldoNXI1N1VORVMxOW1CU3lUTFI0SGk2MHV2UFg1R0cwRlo3TFE4?=
 =?utf-8?B?ZmJTa1hyZG1MK1QxR1p3MWtmVkhDSWlZRUdzZktwMkQ2cTY5aWJCM251cjMw?=
 =?utf-8?B?Nm90N3FSdUxTNFpWOGNwVHIwUlVKTUNEYW5seDJUdzlPTm5aL0Vsa1k0RG9a?=
 =?utf-8?B?Z2R5Y1d3eUttcDBkTzRINDhybWRwQmxNd3ZnQmFjelNiVGFWNjhMZU9BeGpB?=
 =?utf-8?B?T2hYb2lxb1FIa2NiL3NZN1loR2RIMHlZQ2dqcnozQkZzT3FOSjRlbklYdTF0?=
 =?utf-8?B?MjVUbldyMm5WUVNDVFdYMmErRkszdWtvNDZGUzN4L1YyWG9kY21RN1FSS25P?=
 =?utf-8?B?aHpTZEV6K1Q5ZjVtZmMzU2I0RHVqRjIrNWZWYVMwaHJxKzluRnRidlBLZlJ2?=
 =?utf-8?B?Nnlkb0Q3N3NjWFpXUGFkS0R0VFQ3aVRtc2RBTm84VDRJZUNJMGd3UXhYTmJ4?=
 =?utf-8?B?TVFaZVh5M2JQUWoyMGUxSFpnVytkN3pCY0toQVlvd0Y2Q3BYTmYxdE1nT0Jt?=
 =?utf-8?Q?FQ1s/Ya5DnynNcPjYqQ4N5c=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d5230e-7887-4374-c8f6-08d9dcbcb378
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 09:02:07.4978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwxy0fEnFy0k9qPoL4LClPuypx8w963hBoL1hlzm+E2rIB0j0L49B5uK5ZA0mBMCHvWGffOb/smIGLAHvuQ5Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4476
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no point in disabling x2APIC mode when running as a Xen HVM
guest, just enable it when available.

Remove some unneeded wrapping around the detection functions, and
simply provide a xen_x2apic_available helper that's a wrapper around
x2apic_supported.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Changes since v1:
 - Remove useless code around x2APIC detection for Xen.
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
 arch/x86/include/asm/xen/hypervisor.h | 14 --------------
 arch/x86/xen/enlighten_hvm.c          | 13 ++++---------
 2 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 1bf2ad34188a..16f548a661cf 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -43,20 +43,6 @@ static inline uint32_t xen_cpuid_base(void)
 	return hypervisor_cpuid_base("XenVMMXenVMM", 2);
 }
 
-#ifdef CONFIG_XEN
-extern bool __init xen_hvm_need_lapic(void);
-
-static inline bool __init xen_x2apic_para_available(void)
-{
-	return xen_hvm_need_lapic();
-}
-#else
-static inline bool __init xen_x2apic_para_available(void)
-{
-	return (xen_cpuid_base() != 0);
-}
-#endif
-
 struct pci_dev;
 
 #ifdef CONFIG_XEN_PV_DOM0
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 42300941ec29..6448c5071117 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -9,6 +9,7 @@
 #include <xen/events.h>
 #include <xen/interface/memory.h>
 
+#include <asm/apic.h>
 #include <asm/cpu.h>
 #include <asm/smp.h>
 #include <asm/io_apic.h>
@@ -242,15 +243,9 @@ static __init int xen_parse_no_vector_callback(char *arg)
 }
 early_param("xen_no_vector_callback", xen_parse_no_vector_callback);
 
-bool __init xen_hvm_need_lapic(void)
+static __init bool xen_x2apic_available(void)
 {
-	if (xen_pv_domain())
-		return false;
-	if (!xen_hvm_domain())
-		return false;
-	if (xen_feature(XENFEAT_hvm_pirqs) && xen_have_vector_callback)
-		return false;
-	return true;
+	return x2apic_supported();
 }
 
 static __init void xen_hvm_guest_late_init(void)
@@ -312,7 +307,7 @@ struct hypervisor_x86 x86_hyper_xen_hvm __initdata = {
 	.detect                 = xen_platform_hvm,
 	.type			= X86_HYPER_XEN_HVM,
 	.init.init_platform     = xen_hvm_guest_init,
-	.init.x2apic_available  = xen_x2apic_para_available,
+	.init.x2apic_available  = xen_x2apic_available,
 	.init.init_mem_mapping	= xen_hvm_init_mem_mapping,
 	.init.guest_late_init	= xen_hvm_guest_late_init,
 	.runtime.pin_vcpu       = xen_pin_vcpu,
-- 
2.34.1

