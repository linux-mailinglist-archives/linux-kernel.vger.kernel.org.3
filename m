Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95FB5AB609
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbiIBP52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbiIBPzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:55:42 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E647ECD50E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:49:38 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so3574446wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 08:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OADg3UgKowYhLczGEB28pcVY5skR7AiQxx4OTT83oDk=;
        b=y7Rk8ICnOfrD0j6KSZBIf/1FGs+bqFw3R7YqoVI/qVfeSBtBopi0/B/9M7M/WHGLW9
         8sQO11wCSzfNP1xBq9tdohy2EiIva/8zvzo1EryS9C7qpx40njDs5sAakGeFvUGf2FHW
         XkGLKoG8oXYb5nGTjuKddeuLkC/huZ/9NE4e3gBCUJbF+UxxOZSQvVVwKbTXmER6yQ9Z
         oI81o8C0YLW6iXwwNKq4JAbgAX05DvfFNaekATfYEFmKY5eFb83t6Rc/v931oaiqhofg
         sj/2MUki2KlLxxOiMCPTZxQ7dCMj3l0Es+r+5cNavdWqTjTdytY5fykK0ATuYQmAsDVu
         UkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OADg3UgKowYhLczGEB28pcVY5skR7AiQxx4OTT83oDk=;
        b=skpKDimqyc8EhJOqRgLiV9lGlPd3iZzK8r4SPh1q4BMCe7YXAzTGQpaUvYGrSLONV+
         O74AM8haY5YVx/BoZ1hiWsAqQd6KL4RGb0OCJ6qh0vKIq+4TcdOwvnuyqYNS+XqLvfsr
         N2JJtovt1qNKXillRBxKotpRTXleVo1X2p4gslNF+6w1GPKOEwpSQ+yf5Lu7Qnr3OYVp
         pHTXfByDk4yap4n9LNW6WL+0bfP1bjzJPNTzJTIuxpbdPOT4pcX/TKJAKJ3Cu5iKqr+h
         Blo9q9MUcy5zNoDqulQz2iQY81mbFSGOTczm7hBZ1fMVXis0BDJRUIZU7bjnDZaxgb6M
         QSRA==
X-Gm-Message-State: ACgBeo1sIt2iuOsSXXd5uiZdCK4waaOOS83gEpZegkmX6Lvu3pw2LgIm
        hU7xBWC1dpuJjEh0vHXBbP5t8Q==
X-Google-Smtp-Source: AA6agR6DQgD2vikls/B/Z/ovZVSB1zI3rOVFwzeL8kqqj/tMY/Kw364LWUvbox3z8cINk0MdtZIXAQ==
X-Received: by 2002:a05:600c:348f:b0:3a5:e28c:a1d5 with SMTP id a15-20020a05600c348f00b003a5e28ca1d5mr3221691wmq.33.1662133777452;
        Fri, 02 Sep 2022 08:49:37 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600010c100b002250f9abdefsm2046741wrx.117.2022.09.02.08.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:49:37 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ekansh Gupta <quic_ekagupt@quicinc.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 09/10] misc: fastrpc: Add mmap request assigning for static PD pool
Date:   Fri,  2 Sep 2022 18:48:59 +0300
Message-Id: <20220902154900.3404524-10-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902154900.3404524-1-abel.vesa@linaro.org>
References: <20220902154900.3404524-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the mmap request is to add pages and thre are VMIDs associated with
that context, do a call to SCM to reassign that memory. Do not do this
for remote heap allocation, that is done on init create static process
only.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/misc/fastrpc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 41eabdf0a256..66dc71e20e4f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1849,8 +1849,9 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
 
-	if (req.flags != ADSP_MMAP_ADD_PAGES) {
+	if (req.flags != ADSP_MMAP_ADD_PAGES && req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR) {
 		dev_err(dev, "flag not supported 0x%x\n", req.flags);
+
 		return -EINVAL;
 	}
 
@@ -1896,6 +1897,22 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	/* let the client know the address to use */
 	req.vaddrout = rsp_msg.vaddr;
 
+	/* Add memory to static PD pool, protection thru hypervisor */
+	if (req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
+		struct qcom_scm_vmperm perm;
+		int err = 0;
+
+		perm.vmid = QCOM_SCM_VMID_HLOS;
+		perm.perm = QCOM_SCM_PERM_RWX;
+		err = qcom_scm_assign_mem(buf->phys, buf->size,
+			&(fl->cctx->vmperms[0].vmid), &perm, 1);
+		if (err) {
+			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
+					buf->phys, buf->size, err);
+			goto err_assign;
+		}
+	}
+
 	spin_lock(&fl->lock);
 	list_add_tail(&buf->node, &fl->mmaps);
 	spin_unlock(&fl->lock);
-- 
2.34.1

