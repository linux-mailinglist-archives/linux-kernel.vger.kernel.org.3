Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB45B4AB444
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349928AbiBGFwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiBGFTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 00:19:35 -0500
Received: from sonic314-25.consmr.mail.ne1.yahoo.com (sonic314-25.consmr.mail.ne1.yahoo.com [66.163.189.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D96C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 21:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sbcglobal.net; s=s2048; t=1644211173; bh=tBA9NHxBU/zMFD+tXOVJzRZkwxOKKCihh3QRfhQTx18=; h=Date:From:To:Subject:References:From:Subject:Reply-To; b=OVxdlGV2Z4IgPbaKGMdm0qrueR0HMWxpXdd0ov6wrvxD+AIjnEnXop6Vv18ndBz3ULVH7DT2Seoim5QNm9OtBO7eVQEd8Aij5l8Xx2EEbzJfdrXewXoX1P2A3huZ79IFwZVOIDJT2PX/VQ8L9Ian2e7PMMf9pZk/6v4CIhTOq5R1OPZe77A7AUzNXFKyEMloe2PQAc4+/P+tObkxFCTj8tzZGdj0IC5FE/r0MnZP0Q09OhpGgo2tN0tLI3LJ8HiHQSMil7QfczObyY04hZSgXSKSW8xtGcC5WsDIIgtfNs/HiKIY0MMvKj2dBw4d395jgSVsQPWh0w8gWbQsE57TwA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1644211173; bh=yBErRDjPeLT8ykuLFOaNhqjxucJySZUY87NI2Iog66U=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=jLK62zsWtnbkkJwu39JCptBINtp1BeDWOTzkSEkYgP0TW+1WwTvaOrtC1uQF/LTy3o8555LfLvIUib2RqKJ8zQ/vxNoDxRQW74P+D5/0BXSeBKhxkEGJgNBZs3GnFMHcMz5hKbe9asz8vluEj6MTOCmPzFgfef7xzczLIBGdKYXHHu2rm6baMnNUsaHWZWQcgdgtsfWXvUIUbo41YseEuHjwWkmFYoMqK9C+EzdGSHIVgXN7WNbv2DIDL5iTnkyh+pVk7ORLGnVsdSeyM0S/1SetIO7kT6SW7IOqCL2j24lb6o9Znydh/vPsjeDrHBTKYlQd+9UbZp5EHBUaYFXFwA==
X-YMail-OSG: GbvUAhcVM1nXJA0iLD9WTtCkVxSh2mgxSuOqKFGz4fXDVYQdKwseO8sUdDLfF65
 2fpkcYfGYzLZphr4Ci7Hxd4A1._U1avxI2sK3adFXJe39eruki1I5wZRH.9.pr5UfDMVSAggVaPD
 TvE.1cplWBt29laohp6kr10q2o9tmemZnHozwa2WrCILcteUiA_8J9J5fJIP9Th.G.aGfriyyiA5
 NtSaHepWhz.339zrKv5nDDXPhwYYGg7I0.f3bHk6irtzhRoHNybzbkagIUuwSjmajL3IHevlaiWY
 pQK.bwSzoKQyWPW1ZfPXwnAfjARnks1iEnj.Pf3md3y6BV2Apmlo2konFv9ne1zR5bmfuY9PRyke
 7czKskuR3od.4tfWjxUjWkCkt1gSpJbb4B__e_mMAv_8ca63BpP3cZQXh3bY8EjlotAHpg6Lxgg8
 zICMOmgoDkgZisrFCDKrjFdzaysRFHEGw7j7hfjydToyG6E0dhnDT8PTJrP3K7jwJmla78_VZPZi
 IVFsYF7_uWfVet3YLL8qSZcSyw0o1ysE_EMGBT_H8F5D5YY_ndfNNWEE8fK1aQbdffjmHUqUlceQ
 DnlSobjuJufJkit5dCh5vJI0LtkKE5ibG7r_Pmq0X4JyC23fntfc1SI4i.PBnPr4.FxW3c_L6FCl
 05Pvsg5EiqbFCojD4iDYiq8nQY1AYwPRl4td6xkIEaVKWzz6T2oOfFvKxeUpEjb76OtsLoOjikFA
 JsefjFgwOBBylJ37W.4E7zGiJW.VKBFdImPkKahfZyO5Lsvold01XAZtK2fA9.PhzkRdk4Ncq7kX
 MsIH04SXD24GGTfMe7kK0FIg_gRaSPAE4TqLWgiHchzbkNPIQUq4DaBI.vjGsd6oo4SXWBlEr.Tl
 J3fl.oCdvHawVVPEZ0oBUJbp9CHW4HmjarED_GxFUe_YTjXh5.Akbd0CR05X0ti8nTi.gHC9IurK
 gknM1BDucujDAvLPz.dVlkUHiulf9lHZcxiZ1TZFpd0V2BGGtQfk.he2ZnFZADel1h1oiiscplyd
 57x17MaFzo2j9ePhXTrDnBYbD7IKHNqA4i_HbB0kbkVzCOOjUbkJCRBGnp49gMLCgkYI7lYqA.KF
 4gHlw2aFqh2p7_Rt7a_IMSOByuQQ_wnSaNm_bJp4JQQtVg1ghMCxHIr4r58nJ7ptt6ln4k_FLUrP
 VYzZEMHPMfZlcreDne.1TH64ZJHbCJYtWy8SKR5qVdp4X6_A8p9nH7bJtjkopqGWLem_7Y78iXaA
 upM8nhiW5UTIPG6Fi0ZWhLw2gKs4.HomRWunbg8_YgNM3dWY8rNBalP0L1gCVrEURgfzohPyeROs
 ZN7.e7XnMiFscJGOSHVaWNypV5x0SiY9z8ExsuSixgrmvb_qgFqTVSQJa21tRSpP2ymmEHP8UDBc
 kQYdbu_HMHYvKn3IgO7jmtGv8QNsrJVGOWyjqKffFWapNsY0IbF1hpZF5U3lM2Qo321wm63SJ7EK
 7alNtBJnCC4aaJhO2Z.ODv8uf3yPLZbqxRf7e0ktkb9D_cGs5UjU.epI5CtGOiN6vo36sy7aizaS
 F5uhHbo8R9.B3_TnNWYL.6taDc3VCpunZYqnvt.yJjYeeSlzVB9fr4nWTrJqOCudPZNR1Clp40n3
 1wz2w3lEAFyz2fL9Oic35NXkuBMdfsF_StERpI_lEIGiEWX_tQZbaByPMlFd4j.F4VPMd8CNAB7n
 woiyjhOzHIBnyxFTIRw57.r.NQfpQJLTHnnKou4Q4skXrYJdFt3JbMtBIvVVd0LQgEKTKNt_jLlk
 0KawsYSM8Te5wDHoXay6pQHpLP5vy9qGNEVOXtgoyGPFtrE1ks_om4eMRBzbz4n02gi2.C4yocPw
 hPemFm_y2oxyzdp6ycw5mV8PeHDUi0QZuBmsBS80zET6ffrU5SwPy9rHEJoBql97blf2xmb7t9KO
 jNjvsEJRkJ70jqI1BHBQgCitEaKu71ejnuCsrCsXY2nqL99ij.9hd2mlxSjqbHKHYOwONoCwUrhu
 DDI5WgdWBODJa_EtM_2RFJrKz7H_G7qrZknFiPDXKyfc1fqYerPIUmGIs_LGhzEY02hr60NP2mZw
 HtrPehiVeIj9Z6FXpSlvPYXf8keiRNAkdaBNTvkffFw0gruwYRt4bT.QOBk1O.b8PdwN10wFgSQA
 4F6CUKLcGDeH4RrcKM.XOX.F2DrRRS3yu0VS1IJSEeE9FNLAwCv1G7P0Rq.wPIYaxvs2OjVfrET0
 91PeOCZ5iFOoinxcylPZJp0Yjjewvr50LXP6lJJQEgYrUjmEhhQgjj..Z.1vmd4sWGq8CSzPJ9y9
 _a45fD2I1isCxNziLU8hwlGT2NA--
X-Sonic-MF: <blairbarnett@sbcglobal.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Mon, 7 Feb 2022 05:19:33 +0000
Received: by kubenode502.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID bd718f25de5f7455b9d0a89404075902;
          Mon, 07 Feb 2022 05:19:28 +0000 (UTC)
Message-ID: <cf832948-5ab8-f54e-7335-3381a7444b88@sbcglobal.net>
Date:   Sun, 6 Feb 2022 21:19:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
From:   Blair Barnett <blairbarnett@sbcglobal.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH]: fanotify_event_metadata is not sufficiently aligned
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
References: <cf832948-5ab8-f54e-7335-3381a7444b88.ref@sbcglobal.net>
X-Mailer: WebService/1.1.19711 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hpbGUgcnVubmluZyBmYW5vdGlmeSBMVFAgdGVzdHMsIHdlIHJhbiBpbnRvIHNldmVyYWwg
dGVzdHMgdGhhdCANCmV4aGliaXRlZCB1bmFsaWduZWQgYWNjZXNzIGZhdWx0cyAob3VyIHBy
b2Nlc3NvciB0aGF0IHdlIGFyZSBkZXZlbG9waW5nIA0KaGFzIHN0cmljdCBhbGlnbm1lbnQg
b2YgOCBieXRlcyBhbmQgZG9lcyBubyBoVyBvciBTVyBmaXgtdXAgZm9yIA0KdW5hbGlnbmVk
IGFjY2Vzc2VzKS4gU28gaGVyZSBpcyBhIHBhdGNoIGFnYWluc3QgdGhlIDUuMTUuMTMga2Vy
bmVsIHRoYXQgDQpJIHdhbnQgdG8gcHJvcG9zZSB0byBmaXggdGhpcyBwcm9ibGVtLiBUZXN0
aW5nIG9uIG90aGVyIGFyY2hpdGVjdHVyZXMgDQooQVJNIGFuZCB4ODYpIHBhc3Nlcy4NCg0K
SSBhbSBub3Qgc3Vic2NyaWJlZCB0byB0aGlzIGVtYWlsIGxpc3QsIHNvIHBsZWFzZSBDQyBh
bmQgcmVwbHkgdG8gDQpiYmFybmV0dEB0YWNoeXVtLmNvbS4NCg0KVGhhbmsgeW91LA0KDQpC
bGFpcg0KDQogRnJvbSBkMzU4Y2JjMDA4ZWJmZTJhZWQ1MDI1NjA3NGU5NzIwOWJkZjAzNWY4
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogQmxhaXIgQmFybmV0dCA8YmJhcm5l
dHRAdGFjaHl1bS5jb20+DQpEYXRlOiBTdW4sIDYgRmViIDIwMjIgMjE6MDM6MzEgLTA4MDAN
ClN1YmplY3Q6IFtQQVRDSF0gU2luY2Ugc3RydWN0IGZhbm90aWZ5X2V2ZW50X21ldGFkYXRh
IGNvbnRhaW5zIGFuIGVsZW1lbnQNCiDCoCJtYXNrIiB0aGF0IGlzIGFsaWduZWQgb24gX19h
bGlnbmVkX3U2NCwgaXQncyBiZXN0IHRvIGFsaWduIHRoZSANCnN0cnVjdHVyZSBvbg0KIMKg
dGhpcyBzaXplLCByYXRoZXIgdGhhbiB0aGUgY3VycmVudCA0Qg0KDQpUaGlzIGZpeCByZXNv
bHZlcyBhbiB1bmFsaWduZWQgYWNjZXNzIGZhdWx0IGluIG1hbnkgb2YgdGhlDQpmYW5vdGlm
eSBMVFAgdGVzdHMNCi0tLQ0KIMKgZnMvbm90aWZ5L2Zhbm90aWZ5L2Zhbm90aWZ5X3VzZXIu
YyB8IDIgKy0NCiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvbm90aWZ5L2Zhbm90aWZ5L2Zhbm90aWZ5X3VzZXIu
YyANCmIvZnMvbm90aWZ5L2Zhbm90aWZ5L2Zhbm90aWZ5X3VzZXIuYw0KaW5kZXggNmZhY2Rm
NDc2MjU1Li5mMDI4MzMyNzM4YzUgMTAwNjQ0DQotLS0gYS9mcy9ub3RpZnkvZmFub3RpZnkv
ZmFub3RpZnlfdXNlci5jDQorKysgYi9mcy9ub3RpZnkvZmFub3RpZnkvZmFub3RpZnlfdXNl
ci5jDQpAQCAtMTA5LDcgKzEwOSw3IEBAIHN0cnVjdCBrbWVtX2NhY2hlICpmYW5vdGlmeV9m
aWRfZXZlbnRfY2FjaGVwIA0KX19yZWFkX21vc3RseTsNCiDCoHN0cnVjdCBrbWVtX2NhY2hl
ICpmYW5vdGlmeV9wYXRoX2V2ZW50X2NhY2hlcCBfX3JlYWRfbW9zdGx5Ow0KIMKgc3RydWN0
IGttZW1fY2FjaGUgKmZhbm90aWZ5X3Blcm1fZXZlbnRfY2FjaGVwIF9fcmVhZF9tb3N0bHk7
DQoNCi0jZGVmaW5lIEZBTk9USUZZX0VWRU5UX0FMSUdOIDQNCisjZGVmaW5lIEZBTk9USUZZ
X0VWRU5UX0FMSUdOIHNpemVvZihfX2FsaWduZWRfdTY0KQ0KIMKgI2RlZmluZSBGQU5PVElG
WV9GSURfSU5GT19IRFJfTEVOIFwNCiDCoMKgwqDCoMKgwqDCoCAoc2l6ZW9mKHN0cnVjdCBm
YW5vdGlmeV9ldmVudF9pbmZvX2ZpZCkgKyBzaXplb2Yoc3RydWN0IA0KZmlsZV9oYW5kbGUp
KQ0KIMKgI2RlZmluZSBGQU5PVElGWV9QSURGRF9JTkZPX0hEUl9MRU4gXA0KLS0gDQoyLjMz
LjANCg0K
