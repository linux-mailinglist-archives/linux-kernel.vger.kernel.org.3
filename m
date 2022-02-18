Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89A44BB078
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiBRECL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:02:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiBRECI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:02:08 -0500
Received: from sonic315-22.consmr.mail.ne1.yahoo.com (sonic315-22.consmr.mail.ne1.yahoo.com [66.163.190.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E42B26123
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 20:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1645156908; bh=/pLDRequG8GfM5XOyTepSSAIHTdVgBO2aqGX88Fp02g=; h=Date:From:To:Cc:Subject:References:From:Subject:Reply-To; b=buCRcyrYneqba8ekPeR4Z5hNi4ZtSTWihuocePWsudqu7aSDZiyU1Lj8D8ZQg1CjRxfBJASBNl6DYp5HthkNnAHMquwYTi7NTK6py+occtpGGEK9NRDkTcytL9eZCRlGAH67rNq1UjwhCI4Afc6PSMRrNy3oqThmsv1ekHVk6uSTPn4yvxDIgs1NJs4INUwsUopzn+yHf0msA8N8imTb68zT71ui9lFmyMgk0YKeAO0LlaLFkz/jHXKO1TzC7LZ2ZmNtykEftZfvKY/x5lDphNMU8VKdEo5VMqoDQDm7WqPb1+AQQcYtvH0qF+zeUGimC/Rf5PCMFYghgouXk/fy9w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645156908; bh=nv9tW2p2ynOWMc/D4jszk0cxF+eWGpPHDxeBwtyADuY=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=KAp1rWUWa8tWvMzQ+qdfuVSw7z6wacthTsCG9rWeYIzQOo9L4W8G5R6vPIu2uoBu/nOglAHqRSF4th9VngWRaqXH4/Slhefg9iMn4hEC0D732k07kwyl495DVu9xxHcPkMX1R+EZOv6opSEMhz2RYGBY31TLBxYCzsSgQkL0tPVAhpaqnxxrWBhimsBQp0NfBF+LwNanab0awwA0M6CaZikDiQb81rdI34mNqJyK4QFRyCPLeEJhvj7QhXEmT9M5ZXoeaix/pKiadUJz61BtcL+XonC/oBvPltEFsjaFGLJqA7IVi4xDDDlCOiAbQcDjnYwmHy09ne8NYxEVUfrfDg==
X-YMail-OSG: QxEVqcgVM1mViik7xmzj8RRDdO4AykdZj22cCG2et4.c26N15_Q9LHQgWmidSM7
 d9OGB_dLFLIU0RVuzKJlhyVUviHRh_DdyK0.tlp1NYuBXevUNgIRu6rCpTsnEbq0Ym1hw79TXgMP
 dgCbR1dvymxQK5UgbL6O2e2fMa11XJG4UCRH2L50d5Gn0mkpgusVhq3hgzRiYmdBW276QPM_LJ.i
 2I4nxX5PApvqnn8zoTpSdSxYo14Kr1olLBfg1.91m55GEMJL8X5NLdD.4Xeb6OrOMXpWrfYRZJtT
 lEW4vDrBT3TpBYvh4xls80A3.Lk.97RUpGsckF0usHepQNcSGuEzLI_T6upeb94SXTQCVgCh2Q6o
 ebeZZX6RUC.8rHchy1lvO.4euPbQf9dGj0tbTgC57JIqqKgqiGFxisxPyr1wKQUSCNNw44hicSAa
 dPc4X42Uj87JfdjWLJBVqDATPeGHFI7M7BkQcAKoIgucTzPNo6oa3pxmtforBrW6GLnbKuqMlckz
 Hj9Kd648n.Z5PM7usNwCo1x0RWNHpDw91YSn5p7NpfA..EBPq.ECN3nj0tLKdQWz8UKeC62Ev.iz
 jO2w3q5c7CcL0DAiStJbJoj04xJV7zZUNvcLTgdrNVa_zvk16HjOC3AAwyGzIQPnOvwaA4uCQfgZ
 ldvSIOuSupYdsRt72V_Vabu0Q_g6zgNby3spcDkYkU8vCQ_VRHxsQt9uJarduN33Gh6Gxems2gD2
 AMTgrOIvmqG4UaBrPMlv1mejEHoKCWKB0ng7H4ml2Ygd62ZLFAVL8chJgla0hLRGSbMbhP_1fGX.
 df5Vq8wPqH8HF8eeP7HAd9RHKtqLmlNVX8Qc31U6niLC6GeUm0XorcYjOwsxV8dbCZuV0WmfdS1V
 mFDm31Lzwypkbv55AsrtrtI7hManBnBx0wxdNdZxD_bcehvkOSQKYXmSajT5qQZ.8zdNWy6z0lMN
 VnFJvDoZnE7Zt_guwYI8ZqDLpHIeaRwKxTMtnipHW9Pm0_VScJY6CfDd_dIiMU5Je2yYIRstWgMB
 DRzB6wxjiJhgwppDxFeZISFzkqQc6baHaHWxT..bFtbq9iEQ_0P55nBQsHMEelOZ7KQRK2gpzaTk
 B9Dba369zAAloq8hyldmxqG2QVb5V32vDWKlSzzVQiqPv0F9YyU1JiMoKaVqZispbRJhGk8whg6o
 Zf.jKKPwiXMUaT9UbHyKMFHmVjC0P2VxrogCUtzVtHkXRgg.r072o5JXhZlQXThmSQXOk6LjKULR
 ncPzOEUB1g3RD_sy7pfQan8FEq0VNIqQgubTzINU4cei871L3daqZLuavhBnRWduDOKeNsMn5.uA
 en8H9oMNjRJlsk2BBUYo4NXDF43XqWPMaxKEqaxZHdkcwfR9JR26Psski2W4tCPxLwpJMPmI6eSG
 oR44yEFrhzLJyoDPnpCp4LJh54XJuVxE6qqGi1MIrBInoMhyyi1JVrTzw_quz5UcW0zUqDkUSPEb
 yu03MRMtXX01RS43Bla6W60gM15dOB0jo_AWbzBSb7PZLhDTKU_ZOEzPydZ89ZkPR3kRFZ4qymcC
 xGs3ZkcAJprkZ.mbkdEG6BKbwlS12LZFvvwl_K6HcN6MhY1i_ZyT6YHK0x3R10spEV_NcMslcXCO
 q_BztbQrwPmIHdhOkqyAcB0v8aAky28GhwvXM47cEe5SDmBcD.e_ccLWj8ku_OAkwkL2DaBhwuSi
 ijZLg2qryxwpZGzLrq4rHPGGi81ITjYK9UZgEV7GWLCBmc4__nX.Crjq5ypM0gsJSah.RCccNhYV
 y904udjFL6tnIaKJosfBV8c0hdcUcqoTERP2C6gta4jSfAgY_vyatk32EO1slSiZ2n2aOs2oCpoL
 ffhNXBmd5N5qA0fvupAlKYQ6o4A4tGir76In4H272lws9bhCCAQSLbHYw8BrCV6reUF_OwzK12Hq
 Vw5d2ieqpwg2.t8vdtTSbZONMUzQhsqCTN9lBo_xQWH3lT0tSeHdOm4NoGkYV7Kl7iCJNn_Jhx0Q
 OjQMUbzFHUMPbhtHtgAlYig.OhdQC9aaM1n4fAtCp4Dpo4bC11YPiMpedlIjQaaGfuSpMTsKuE3G
 aOr9A8Z.hTcPsRWXFdMfi.oIvJmLrkMNzB2_YXOoyBdCpXLEkJf6VTyIFY85ebfGbjVOsmyjRAgz
 cbFzR9MuoYIvEt_KD8xQhkZLlZo9FrehNsvZcqORZoKPg.wsj.7lXSJT8G8_D0wL41T_xcL7Gjhn
 V9FMiOw--
X-Sonic-MF: <marcelo.as@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 18 Feb 2022 04:01:48 +0000
Received: by kubenode522.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID caf70707316f0e4c5d07448c65571989;
          Fri, 18 Feb 2022 04:01:46 +0000 (UTC)
Date:   Fri, 18 Feb 2022 01:01:40 -0300
From:   Marcelo Aloisio da Silva <marcelo.as@aol.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: move out assignment in if condition
Message-ID: <20220218040140.GA22796@snoopy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
References: <20220218040140.GA22796.ref@snoopy>
X-Mailer: WebService/1.1.19797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should not use assignment in if condition.

Signed-off-by: Marcelo Aloisio da Silva <marcelo.as@aol.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 46a49f30f900..6eca30124ee8 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1318,7 +1318,8 @@ static void c2h_wk_callback(struct work_struct *work)
 	evtpriv->c2h_wk_alive = true;
 
 	while (!rtw_cbuf_empty(evtpriv->c2h_queue)) {
-		if ((c2h_evt = (struct c2h_evt_hdr *)rtw_cbuf_pop(evtpriv->c2h_queue)) != NULL) {
+		c2h_evt = (struct c2h_evt_hdr *)rtw_cbuf_pop(evtpriv->c2h_queue);
+		if (c2h_evt) {
 			/* This C2H event is read, clear it */
 			rtw_write8(adapter, REG_C2HEVT_CLEAR, C2H_EVT_HOST_CLOSE);
 		} else {
-- 
2.25.1

