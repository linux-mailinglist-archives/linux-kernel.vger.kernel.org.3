Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465814933C4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351378AbiASDtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:49:40 -0500
Received: from sonic305-22.consmr.mail.ne1.yahoo.com ([66.163.185.148]:40613
        "EHLO sonic305-22.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240579AbiASDtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1642564179; bh=m+VGWqd6UmspiGm9uWk3K3nAnLEF655dLkMH7vhBU5g=; h=Date:From:To:Cc:Subject:References:From:Subject:Reply-To; b=Br0zC7RbhuWy7xm5ZJhBC/dyBjo8PaWltgLjxnQxszTwvuscKmP+/9bvHWiv9BC65WVw6V6cQ9WHe7Qp7dfHztFOFSK0E7aodHeCRDFroQGZ9sXyp6Ng53HrpQ4Er/oqbhRDWACJ622wMiM5kuVlsJWg9PMHzT/uCrEfW6DSsIL4wezfcoHlPCDeYO3M5BtBVeFh+iCdUyD/AmDJ44lECxaYSylthxjDnPqZ9LJOmP3mr/rejdNpS2Z3UGq0r1i6LzWodKwoK9asiBe6nsy2F8EU19n/ZgUf2JYk3Dp0PLLzpewjQZj3VQvWxwlk2SGoApZySDoDcm1pUz8o+DCOgw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1642564179; bh=N0WAx5GFoN6YKV1U2btI7Pts9/wIeEVbTkVrkrVbhcT=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=LYQQ4Pj0/knhqzAfnDinNw++1SgKeDIZ6ud/IZw/eTqc2/ThJ69SQ4YzDGLhctSaVI3gg7I/SihXhM/cA73tM606goNaO/CnL92XzwP2ve/VcBtrFmg9N6sBjy97cKNeMBIOzbIAfELFZ2hPyrSqB84R4nB7huy0zXlpttwUKfIePrLNRZN+95b2U/R3ckFR1OjTLPgNsaWxHu91QLbS25dkNwB3yUUKzE0V+pFiV1glF8FX0ilI6/3OOomD6SuSf5reeY7FCvrkqCdMQAqRYf2y/U3x/TGUOZxlA8l00m1Pj4trcThARc3IqL/b5hcRI1LYduy4OcQ7F9NeFGDJlw==
X-YMail-OSG: y58WHGQVM1kqE_futine8I5jWDeGYdxaDlpKjuh1P5HdZI1RPG0bba8HvaAhLhA
 e0n.mcOlIrJIuk65aWMvsGDTbVdZXNql1PbZR4OmGYa04XIJdpP9BfOZfqHNTHaPpvcwwAetP42y
 6NUfF6Bks1yO1m36mbhNqXNY8HsuZDt0ehQ4fxGoXwqhdmDGto8G6_jNOcxyJWKOW6T0CwHW1FeE
 NB5IuOyY95.kqX3k535tdBvFQg7cR58Lk412yH4AojxOCOLy7Q_WF65T.eQfrgkmE7Su7E8jdTBU
 WCNL3JeklLLFXmlugbqvelPXDljOolnVCDuGWBasr9ZYErhbu_HN9RRHYjOm30St.7Zfu5V1sHDv
 Bi9mO4MO_5ObiwsJQ6Rq.aNMDEVTFf82ZULnxiqV96_r3qcZYbfmIyefPDrdK12KP_KCS_EL.hsI
 _ebnd3zXIyk_rz.hbvBSjyoSiidL8.HVvnSjn5MEopnWPhjAhgasTP6EvgA9gjMscFMdwlSGSLCd
 ypq50ncypWQV4s0DNMDIC3OCR24xwTYNNV1_YjVB65Dm7d71F14QmlZ7qVrUwHBLvL24dm7p3JSr
 FVyx95Voe_wNAEbYRiCvuO3yuNp_mqeajZHCyoyXtG0lgM0VclIn4.L1JJ2XDL4DqsGERFJdRGZ5
 TYMc0_.aj5venpae5I1aScDCVgn5WTLTS03u25i2owVMYaoS.OrtZrug7tWrurE18.xFQ6xyl_ma
 ivpJxZ8gvBNN8APncBmQnAqF6XPQhPVshx7DrfoFukwAHvMmCTh.jef42VxIHn4uRaWcojiaO.uW
 L5uN.2zFa2lMHjBiH63PaldSglEbh9W1dsTll37jEB4beXgedXa4ytQMFH5QD5Wm2Z0qXxNs8muS
 jisilwXjSD7qV1GqdCY48k1BO0w6Tldt8vUMNl94BH5d3MbVLbqRRbY2tUGDS1oCrcIXo83DKvkL
 x0whZXmppe6NOuLP_brsqEtfYWfnwoDM2QWKaNbk1i2R7lnx5n50Z8DmUERgjwWYHtJZWQqSHTOQ
 iBGJ2.Uw2Q4oaqEnZfsLeKZebVG5MU9EfrepBykmw95iv7QPbY72W.ddcfdBh2gu.7ulxFDiGhaB
 t4okIRbMEU5QKnZWrkXOq2pGDscD8irHIVUtEVpQvTMWfXCDNxImRQGy8tPQZF0lIHefp.CAKgl2
 e0FnRb5cNiy.K6S7cdU9gnprQDj.H8ZSdSVlqps9G8IKTF5KWJOye5KQodIzax8AAhwIlIHZzHTa
 S.oWU0teJdlvOK00DQQ0ZRXMSr3nGR5jQrszyhmy7PnR_dhABRG6cVAuGmb8hLaxpEDJiZL9vOWC
 JbBZ8au2sggBylwmF4S3Hj.ngSb7Zhy1OF5s0wbixFtTfr475Z.krCjroP8dA_zEwObjvu6FMldk
 ZSkRgx4ymNGUAz77j_aIs5wLgGpGZ5yptBRlPP2fXkI0XJWcqe7ItchGY1__UD9oevVWacJqzO8c
 h3B8pCLALCGIte.ClIJv9KE3Oe9EvT0cdkZ8UOqPvPDkOHiuWF3iofMbLKJngtLXcuMfdEzBfbCJ
 KJhBLCO3YJqo5ID0cLAc17yHA47T3DO84ujQz69R29XW4LuY00UF0LMK1QDcmHeR8b88Ch6ZxmI7
 ZPj_CzqfYltrQNdRE5d_LpJEYSfy4cuybCFJ_5Nxl339cld4y9TUKXcvGoDVsO4Wf3yOQ7tCingQ
 QujnMoUN0MOHtUYkLhK98HfEjNNho_ZVH.KARO00xxY9wwgAbhHj6rpQyTxd7uhv5oDpVM7NG4nS
 UJi60LMHZJJl5NFxoL58SqduDbwbaLy0hyt162UDUcQBGYkQoZJw_SUsO40Kg49Wh1wk94AbUH9q
 MkbMRpuyuqxcBE2u94T_4TdY95UhPh899Zm_GAW..8tYVHGlHVr_mhdiD19.R9N7qvo3TZUJBJlO
 L5FV.ijorEClZYR6JRYiNUNPZDxxcDvE76S5UTO9VL5xfnZiCTu6bwl8dke25k30BURYeSpJzqDI
 cLvyW9yQipoe6XKBySHDBjAHicFvU5K15NldJi1XiM4Uf9q4uGqPMuk5Sz8xFXyGowShBKGZ3lSI
 194P2TpOjqxS7TFOkw9hrjCmLzE.6QnmeUfPbeg9dWOZPuyER6HMkACWvoEolTiBIAJBTUni..S.
 qACG748.t0pEuTDYWMloD025Jy2uGRZEF7zGC95QEsXDHLbPVilN5j49eKcFyRgyG_acxUGUZVpZ
 T
X-Sonic-MF: <marcelo.as@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Wed, 19 Jan 2022 03:49:39 +0000
Received: by kubenode517.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6d758130fa539a9950969262ee58e6fc;
          Wed, 19 Jan 2022 03:49:37 +0000 (UTC)
Date:   Wed, 19 Jan 2022 00:49:33 -0300
From:   Marcelo Aloisio da Silva <marcelo.as@aol.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: remove unnecessary braces in rtw_xmit.c
Message-ID: <20220119034933.GA29744@snoopy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
References: <20220119034933.GA29744.ref@snoopy>
X-Mailer: WebService/1.1.19615 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary braces reported by checkpatch.pl in rtw_xmit.c.

Signed-off-by: Marcelo Aloisio da Silva <marcelo.as@aol.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 8503059edc46..3142b2c1d43d 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -133,9 +133,8 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		if (res == _FAIL) {
 			msleep(10);
 			res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
-			if (res == _FAIL) {
+			if (res == _FAIL)
 				goto exit;
-			}
 		}
 
 		pxmitbuf->flags = XMIT_VO_QUEUE;
@@ -711,15 +710,12 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 
 	struct sta_info *psta;
 
-	if (pattrib->psta) {
+	if (pattrib->psta)
 		psta = pattrib->psta;
-	} else {
-		if (is_multicast_ether_addr(pattrib->ra)) {
-			psta = rtw_get_bcmc_stainfo(padapter);
-		} else {
-			psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
-		}
-	}
+	else if (is_multicast_ether_addr(pattrib->ra))
+		psta = rtw_get_bcmc_stainfo(padapter);
+	else
+		psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
 
 	memset(hdr, 0, WLANHDR_OFFSET);
 
@@ -1471,11 +1467,10 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	struct hw_xmit	*phwxmits =  padapter->xmitpriv.hwxmits;
 	int res = _SUCCESS;
 
-	if (pattrib->psta) {
+	if (pattrib->psta)
 		psta = pattrib->psta;
-	} else {
+	else
 		psta = rtw_get_stainfo(pstapriv, pattrib->ra);
-	}
 
 	if (!psta) {
 		res = _FAIL;
-- 
2.25.1

