Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DE9591CC1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 23:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241032AbiHMVkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 17:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241017AbiHMVkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 17:40:41 -0400
Received: from sonic304-25.consmr.mail.gq1.yahoo.com (sonic304-25.consmr.mail.gq1.yahoo.com [98.137.68.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497A6E06
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1660426839; bh=PIlufvsaPsyGJwlW4Tq6D4v1lbnSLieh/roTabG3bLk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=p1itavqn3ffG609jlveGZZH2gkNFsWKJqxCsuTD2xLk8usezC/U3cujO7B5LH+d4MCIgr1MOPh4l3DGmerSJ1sYiEQyCdGxpV/BPLNEzffS5Y8OTPSVX0hY1zbHpY0aB4MLb32yLbG0dWUH1de3SEVtjqbhkjPlXZ6LAiQMbDXRNET/QlNTQSYFCPTlxTW3ix34cj2HYLbnNM5+FPY1JH0rmEzOHUHeP38DP3zAHKCuiT3uJZ0PguvVsu2Ug57BSANi9f3fSFy1phONSSpug4Zb0cmlMtmpuouh8DGtCVECS41EY+LzgMt4XnEmqfZHoRZU1mYjUR2sIeR7NcgyA+w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660426839; bh=GSdSnTct/aFv3F/BFRhCVd4786aWn++1H4Q6NyrdEiU=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZvUx8v2KifxKSZT+0AgmeCaiyShR9gjzycxGeeoE3sy9roJGP/AAu7ilSm5ODd3A/dc1+F4HlVn1PKDpOhrge//tRTNvSA4wWcsun6T3uAgMCzQ+W48S53OJHV7MteDJEg+VG0SeXhsq7dqEhAn+7vD7926RhEW6C1PV4E9lKDV3EXQ8qBNq7HlZDIxNgZ9dJIWMGsxyrCf+ujG6F8mkHuBfI+K1NdAsyav4L02PZgUpB9u2wpg0hVbX5/cg8Cn9Hu9mAcE0FG9zrHDJbJoDQL/Z+FLF5THp0HDAo7VdyDkxNGZSWYeYA+lrvjM/gq9m841a+XOogyu1lZufPPJr+w==
X-YMail-OSG: TebSG6YVM1nQH6Dgfq.F8qvUCnxbvYNhSxtELVhuO9v17kdGSK8oyKXUJdMdTOz
 1eLGp3bUBQm2l3wY.x7sRYB08ogP7WBXYrPlE75UYIeW7oYHfJ.fqifoeljDqBF4ehRNn78RxwjL
 CAbJLsAh98XFMmyWbzjK61YcgHnTk4ylbuU6YfcMU4WwnDraGubO1SJ.P05IznFC3r_Yk1WEkQCi
 AyytDwMhldDUEWUDYIiW2IrYVHgABwQ5MKYA_bRiNXjRt2JvV4CgsdnQ9hndXxMuN1k0xiJPFudd
 mo7t3f35GyDvZLJp_4YgYRzLNGd2n8JmjmulwBsXA6ZiJ1wYGfni8j__mJzjv23L_4FaYa6046Na
 sI57erJyP4HxZ6Zy_r2Lvp_6eLY39NI9LBBHuxCqt74l2UG4p0RCyZQyUUuBmk3As4rU9V_Va1GW
 9yVwfQdUtV5CkHQl47gVxpTNwMlTxnyMwv.NtYL.I2Z0pjvy7aOh.ojZnrdOnj8yDzhbclKVv2FO
 PzOJCH7OkpoDOL0HOQWB9mn9up.Tp7sVpSVrmjxp3FyCB8L0_cupKwuFXj36CQHg5U2G6L7VPuGR
 I7PrCBi2tL90mYtTq3h6.btJlGlgGDWeGXwZD0B_wpWKNwgXyyOFosx.BY5HGAEqU9GZKhGlIJaP
 UTp.n.15rXxZiGjBFdt8SQJq1gBCm8cfhhpjbJtfdSPZcgz.qDDxsW4.VwGWsRqg.8G08vcgvD0K
 1bYU_C9dRiJCMMFbRu3y9Zs4Sp42y7aT3r5Ewczdol4oNLnoDkpwoAeJK5nz_GX9DL62sfcwpXgN
 8CJWWVL2XM.ABsIP.jv_oLyXwh5k1er_Qhc6C.xbqPjbN3ohsg6ho8_cGeJm0FuWyE9k.h_vsJle
 VBzxGshw0OGeMj7XT3HGMFil1mTFhziLFUfxNIedZjHWHK0pPjEbbJQ9T0PK6aQvTQbPJJ6b7Hc8
 9h27qaIq3s.VIgOj3.90v._8Ko9kjKE_hNjXuubk6vQuZE8HCFZLaZD4EBPoo0PYSscCToNQs0XR
 ZPLAPSHZOGHMBnIHlPKPhKhVWSqC6eodCREdwmVT7.VsAlLJ4tXwbRToMiKUQC3tcyXYrVqWM0bb
 HrAXnuxv54JP48OzSWWiEwN4VeDDuYghTAhO_WOSPjYRvrh3An3n_Oc9fjUA2jbtdWlmCkqdpKAi
 SJrsAzm8lD3Woxep.xTcoI.VSaqmuUvSGde2EwL9Hk1uFkshCDzGSSbzPY1BZ4w7kpJokKbKLY9O
 Rd_dJSylAMevviik0CYoKIVcj4ZsfiekQDi6UOsHZ1QIvzKXs3B9F77la2_UV_8026MQne3J9xt6
 zTRVXjzswJaPYOoK.vQL82UQ8UVQrtQFRMDCpLFnA5SIxco1srVAW8P4Wjlo4ZdKiW5H73Jqtbk9
 TyPcpfxfXSs0WvVC.UT0eSULSYka8dJEbLSU6a5J0AIgNyi2xSq_pQ39l3L5H9HBVjdwro.cJNMd
 eHpOZXScwlweiXvqEJdbVhJdn9ocpuhxeal0ZFwrITCuHRhTYBU8sR28Iov49ZFbuXfeu9scVS15
 W7Sa9YL.5BxR3U_ViGvkpPF0.CkdvGXvwiocCTrn43.buMlt6gJJL3xJexup9qErEVA4fOgxFbn4
 j7Y1eXErMFv8PRATkpCFdHrvIS4WpEqfdTl0Q1j560j0zUN6IZLzoA27qxXC_FWQUUcoTnBhKH4Q
 xnE9LOTU05PxWq9MmaJjcxHlUzTVEWtHA._xlGxvOdN7GWgF2_3p_hbG9A.5nbDMXmqkIGofKavC
 eC1M9BfIzCneCJ48DiVbk2wKymSfzYcdJOJKmzFtU2GELlOl1lvvEQAsIviCFIRkfgZlxIpDgkIj
 LQVHj87U5rL5cukxpjyxM0OkJbSdjtozS780IWj3exg2_Ya8l.hgTWrUeBmf76WM36cYvRDtsrJm
 RGngDXaVk4VSj8pfH8uTjZ.zernyDqqMPI.EvMpsafE5TRnnXEBV7Bqc_DFOuWMZkyhFNziTr_hB
 mWjDniknir2nnBtwjv23Qs_pu7xysMZRxQ2Mi6NQ0Pnta_rvXZLb4dRF_2S0A4HwX3GNZ1l38DqZ
 NhLXyWVC_vpomdl2vuTNi6Fq6vfc6YyYX1bYr65BA5wT2_jVMkGKUo4WP0uRPgdWBjoYYQRc5HNp
 J2GuYLEoLlCYYvpHMHB9cxIcEkPLVDQPNVIn9GpUbYaHrusIGa_AygNSTwv9cYjTwbC.TuKEBr29
 i_ty3aFQ63Kl2uduNS8WRSo1L
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sat, 13 Aug 2022 21:40:39 +0000
Received: by hermes--production-bf1-7586675c46-npccb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5839c0cb0572738d7f39c89d274f137d;
          Sat, 13 Aug 2022 21:40:35 +0000 (UTC)
Message-ID: <3de36953-9b8a-d040-c8dd-44af1ae2d56d@netscape.net>
Date:   Sat, 13 Aug 2022 17:40:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: PING [PATCH 3/3] x86: decouple pat and mtrr handling
To:     Borislav Petkov <bp@alien8.de>
Cc:     Juergen Gross <jgross@suse.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Jan Beulich <jbeulich@suse.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        regressions@lists.linux.dev
References: <20220715142549.25223-1-jgross@suse.com>
 <20220715142549.25223-4-jgross@suse.com> <YtbKf51S4lTaziKm@zn.tnic>
 <d838264a-bcd0-29e2-3b23-5427ee0ee041@netscape.net>
 <YvfdYS81vU66tQSs@zn.tnic>
Content-Language: en-US
From:   Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <YvfdYS81vU66tQSs@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20531 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/2022 1:20 PM, Borislav Petkov wrote:
> On Sat, Aug 13, 2022 at 12:56:44PM -0400, Chuck Zmudzinski wrote:
> > Why has Juergen not at least responded in some way to the
> > comments that Boris has made here? Why has Boris not
> > pinged Juergen by now,
>
> How about: it is summer here and people usually take their vacations
> during that time and everything takes a bit longer than usual?
>

I did a search for Juergen Gross on lkml and he is active submitting and
reviewing patches during the past few weeks. However, he is ignoring
comments on his patch to fix this regression.

Chuck
