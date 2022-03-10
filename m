Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7AD4D5640
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 01:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345055AbiCKAAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 19:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbiCKAAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:00:35 -0500
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C013D555E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956773; bh=Qn3mawfTU6zuyXVFnxb7r1Zgbfgfem9YSsefTT+IZGs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Z0AHUVBXBh3H5S34h7N0LLFN1Pem17DhmOdsp+HHmKWTaQ0vIVx5ZNpSWsk5E7GXb7jNfKDgKZuWHx0KgTX+EJhT4dwGJqtF8342rVI6K1Gw0Fivv7bHhBlKkg0swYMjFiiCv0wQEKogXk2LZed3f9aiKnvU5F6qWo7/g7FQC+llgd4MG2dQzweUdjPlRCdldvm9yC1LB7m25i+7h0vBLeGspX+1q5AG6j/7OybKvRNZndPpHRQf9rRMVaJG2jgr5QegD0pRtXgRVjxkgupjerZqAgJVyTorYD23qWeMNJOas1ZiW3OA33OBGGKby2JiNDOZzBRPMsSoWEkfCmJxSw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956773; bh=waGFu/15HgY3B1DYoOM2HK81bNtOEyZxEDMwpgApMTH=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ku/pQIJ0uDBS7isvOPCnh/rqerZcQRrdNpTFv3smyZjxQZIQSDSJICupNsW+EvQDc3wpzpNn8NZLG7WuqOd1lyqOPPs3Foa+vqWB9Pze/mhpUKQqz8g2W1q/xsHG3I5oPvxjNwAEZuPMkpftdKvO8Ywfwuy+UQzPXLmW0zAuzjDoCE9wFU0S18r9C8mgkOR0dNPSzjoryAqsA//2zIuHpCGlhFnlj1kHW+qH5x85h1g4ewDGgBa4T+oOaGiFO9UIWNx+06QW5fY5/n+LDPyFV2Zc7VgqFpQe7tu9Jz4YKjB/1UO3uUejoV2/AbydDrwF62CZNzrcJUcU+zcSTlbRzQ==
X-YMail-OSG: pPzVHfEVM1keXy3lV0cqLzq.B1LERk5l4GM_PgesuBRAgdOs22fIG2MNwXfzwFn
 wFJlKX5kABGdkiwvlTS.ty5w8FauagumFWQ3Vxz.2Nkm__V8hBLDLBCPE_4N463bn9mvi4d31.Lo
 5PDuMo7Maf6fZXcrPLc1u87tf7AaSFdVmxQ_TYHj2fN.DHLJN7osCB_632RyOjlOUobW9NiKJO9Y
 DsvkH16uDiBl8pEpm9zg.XV1xaOy_edU_AUa4HEo.PBzysVBusu1Dy6DpcbnWT9amguVoJ2ZOJxk
 z_eLfnPZ78_ASqdoH5GpJhofOMilOqnR1JuKmbEYsIO4DMJNF4orUhF3jmx9.fVCueZhmKXhTppJ
 zwISSbY7roI4od0xvtx8uWoCxm7RoMTvtkPs1mgDCSacszeiKwDFUQNUbAyyA6Kj6Kcxp86egJ8U
 BWc9KHWD0H5pvjyp258aGWsCd3oKydvld3T28Qeh.s49uXLplZ2zAsvR2qggkOGLJfAsnQ4_7VN9
 ElCaSEpfRQUInPALlKgSJfeGMbkqTftJQcXzx7HuulBFuxiJt6kjP3ENidX7IisWAnrTI95G0yhb
 l0hYmvakNWtEwyNXCBlF1akOH8RPACD48Q.bd5Ekrap0B8VXxgmmjB6PnSXesmNFiS80a.G8oLrU
 8D4s37hRvY6eEPpObSDOpLgumOE..QexWOtvtNKBgzbS2dkyquHNcuZLjTsLrIDwOdV1FTnfbSKN
 Z4GNN1FS3awxYGUxDcHf_8kCsGArninpliZy7qDdVYFkjaFUugdA_CehV8Gq9r5AGKXJgl9zXvUg
 xI3gFzU.nFHzKDsV804wZvJ0Ew1fIPtqpLNx554XiYxg0MVJDx7bA.kd79E.AChtZZqMVwz_NzqV
 ZUeeDv49qi41Nh7fMkn6ETtRIEnEUJ3z.C.n8nbqzvk3ceY_1Rsi9qTYPemjBhK.B3oB4.QCFsHU
 .RF8j2yGJqqbBX9HCi0ivgYiSD5Gm4Z3WWlysOeY2Yyuh1BsHyMAdQalA79GIDReL3MItAQ40T00
 QOuOvj11GZkbXe3jnuKcAe1ByQk_rAifuVuoddW1.rklLpUyRjj4yvvgXSlDOuckfta0q1lRCGU1
 IwjADhMEKuw.NQjHoKksuRrkuQn_n62GSF3BKIyVlsWNeWuVGEp0jePEVNwgH4s9omfsiFeGD7mZ
 U4FJn3iVlP6j9EdUXE9tBEsvgBLLyshng1viiYjmH0XadXPRmO7JKubMy6BiWJ3JHQIFY6TDPGGv
 Sd0wG0.bJBFD5UR.Y9U7lnbi2_3yki59.0yy.kdFxKN507rBkB38FwL_6Q.dwXSL2QygYFmty5.2
 X2MvITLXHeVEUxWIg5WvCQrshktmGh6PFMzZcuE.qlDLfVCqNeROrEBmVfXDXucPkF0d8WWpJ3s2
 G34.C5ok1rb3AZIic60NiSs5neSXw8_RsW80W4GPXsgMPSnRbTrInCzMsEknXsJWTqM0mZpssEui
 .EnbHvQJJkz5FZeNBpEojBL4HB3BiPh8pDzBqg7zSrpMJsmP4GyV9dNUSgreeFl4TU.KcKBau31s
 4Skn4ACSiXL1Hcvbstkq3TSx8VNMLELwzTnTJsK1faYI7.SnW4RFvZ59DQ0vfKJUd0RaPd3KgggH
 .cO5s7fZwDfBLq6Vj_WUbn0bIJIN5qvocVuy7W6E7CK6PLC9tzaO5S1EMO8fajjOxT6noLEjNhZO
 Nu9wBIJbCtBQQZCRKp3B4pdfAmpgqzNzne4vJCDAeEJzhuuuFZAx92JKMfS3JOAnhiSQouc8n3hb
 EcDMO52NrxXU80c2IX.mpaDrJSSeNCMpizvF0sIpxiSWV82wzvcHWpeGnhd3ptwtFd.IcSKlRPps
 9F8FT5rPa2pRSTQXibt5rwyxRKA9UbKip7Mxe8_TWFm5lSdisdRIQ1o3a_GPi_tU4.ktbxyHwDKe
 5gM_nBVexbfefQvUv9fcCXQfS0fzLGZBcdeZsW5ub43fgIs08Ba3TwYiAlzRPE.5J4f17RycO2cV
 1jBOl4BF.SO_Oy77xfmdNAQk7c_7pp5BB.fBWAO.4tFd6AeQ5wD6zd0Z4JRd8pyos_bZ7cm5_KYf
 NrOWDrJlMrMxm41t2xsAXTlJqS8VcmU0GinDAyoclnrchecf1_DkLdyqfm_sjRwepbYzC4s9v0NH
 JwZge4XI2RZ4wmOfTsXGDMzSH1bPk4yuUqRrXV3Dpf9lMnh1RLAirEvvCnrn1wmT_qb4Fnd289n4
 aziq6A9o08pKPMxMP9cOsFlelbrDiN6oZvA0IP42CJbTPpraQiyfcaq_K2VC_LBJt9SH_IPOBnU3
 BVWXUkHQwUAj2QBNUvxtG77YkVIE80w--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Mar 2022 23:59:33 +0000
Received: by kubenode510.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 33032615d5bc216242260d2cf82dc739;
          Thu, 10 Mar 2022 23:59:32 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v33 24/29] LSM: Add a function to report multiple LSMs
Date:   Thu, 10 Mar 2022 15:46:27 -0800
Message-Id: <20220310234632.16194-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220310234632.16194-1-casey@schaufler-ca.com>
References: <20220310234632.16194-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new boolean function lsm_multiple_contexts() to
identify when multiple security modules provide security
context strings.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 6dbdfd12fd79..13bc38970498 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -232,6 +232,15 @@ static inline bool lsmblob_equal(const struct lsmblob *bloba,
 extern int lsm_name_to_slot(char *name);
 extern const char *lsm_slot_to_name(int slot);
 
+static inline bool lsm_multiple_contexts(void)
+{
+#ifdef CONFIG_SECURITY
+	return lsm_slot_to_name(1) != NULL;
+#else
+	return false;
+#endif
+}
+
 /**
  * lsmblob_value - find the first non-zero value in an lsmblob structure.
  * @blob: Pointer to the data
-- 
2.31.1

