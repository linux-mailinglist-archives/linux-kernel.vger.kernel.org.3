Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930B751BC20
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354323AbiEEJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353830AbiEEJcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:32:23 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B0E527CB
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 02:28:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d17so3889824plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 02:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wZYZZokAYbHkoKNpRYcwId0oz7EL0chjkDT9m64Fs88=;
        b=frO0QTqQXRV8E6KGCzVWlcEM1m1UhQ4TJEualmfLMhWKVHeD9bQjGbFDa9vzYPUuka
         DeGYLwpgyIWguNfVCUiawol+ONYQQkIOy1D4AgzVvZH6JMfhehtgEQ79N3b9vrs7aMZm
         tZgP45sGboQOWU/O9DHfTYsJTT+HN5DxYL9tEeWDfMyidE942J9gtMG4RCjLoo9ZItTS
         /4YeQ4COn9FR9fxhQXGcVx2Nycfahw6gAyGLs5ToPr/apCyS/KiHsA/S3lOrGGIafymD
         3d8rRjRUYXLw9g0T+PgkqBV/F5+BSf+cvCl2lA5oQ0fif/hrULyKmFu6GtfqrObuZHiG
         QU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wZYZZokAYbHkoKNpRYcwId0oz7EL0chjkDT9m64Fs88=;
        b=EBR7jkDH6cE6VkuRK/0E2RgxJfd+NxEQAS+vZavbah7Cm5JzWgtQj7Mk73U3FdfWwv
         FpkfRBkECOsewCPlT/2H7HCA40s9lqr+dfb4ayhw1t2DYEDwAnHiGwTk6xyIGXBcQZCs
         kmRZ/dbw2d+cy8PErkthqFCSTux7c3Hk/eePEE9rw+EO9l6KD0lzoWVVuP8Zd3EjKiBm
         hpP17jX/7kHT2h3i0GvPLMc/wm3ulxGR1SPFb6A+xPdsqH+W8Awp3Wuovi8p0PI83hEy
         91YrUwwknaXEafWCVcUBmFri9dsxYQ+O6HiEEPtlMw1+wGkAMHyXOJZP6+RSvylSV7Sy
         rNag==
X-Gm-Message-State: AOAM531Ti38QsTYQY7XkjGCV+lQ0BcNfRHXRGzbiC3Md+bq6x2uTLN7A
        Y4bm8o9eTFCWlGJRcE2E5t2bVA==
X-Google-Smtp-Source: ABdhPJyRhLD8aVEulYsSZpHbptbu0aq6Evj2kroR4kaUsEEuicOm6LJ0kDXiTRRvBaX9yj4McIl5XA==
X-Received: by 2002:a17:90a:a509:b0:1ca:c48e:a795 with SMTP id a9-20020a17090aa50900b001cac48ea795mr4842210pjq.165.1651742888960;
        Thu, 05 May 2022 02:28:08 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id t68-20020a625f47000000b0050dc76281dcsm884224pfb.182.2022.05.05.02.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 02:28:08 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        pizhenwei@bytedance.com, davem@davemloft.net
Subject: [PATCH v5 1/5] virtio-crypto: change code style
Date:   Thu,  5 May 2022 17:24:04 +0800
Message-Id: <20220505092408.53692-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505092408.53692-1-pizhenwei@bytedance.com>
References: <20220505092408.53692-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use temporary variable to make code easy to read and maintain.
	/* Pad cipher's parameters */
        vcrypto->ctrl.u.sym_create_session.op_type =
                cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
        vcrypto->ctrl.u.sym_create_session.u.cipher.para.algo =
                vcrypto->ctrl.header.algo;
        vcrypto->ctrl.u.sym_create_session.u.cipher.para.keylen =
                cpu_to_le32(keylen);
        vcrypto->ctrl.u.sym_create_session.u.cipher.para.op =
                cpu_to_le32(op);
-->
	sym_create_session = &ctrl->u.sym_create_session;
	sym_create_session->op_type = cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
	sym_create_session->u.cipher.para.algo = ctrl->header.algo;
	sym_create_session->u.cipher.para.keylen = cpu_to_le32(keylen);
	sym_create_session->u.cipher.para.op = cpu_to_le32(op);

The new style shows more obviously:
- the variable we want to operate.
- an assignment statement in a single line.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 .../virtio/virtio_crypto_akcipher_algs.c      | 40 ++++++-----
 .../virtio/virtio_crypto_skcipher_algs.c      | 72 +++++++++----------
 2 files changed, 59 insertions(+), 53 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index f3ec9420215e..20901a263fc8 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -106,23 +106,27 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
 	unsigned int inlen;
 	int err;
 	unsigned int num_out = 0, num_in = 0;
+	struct virtio_crypto_op_ctrl_req *ctrl;
+	struct virtio_crypto_session_input *input;
 
 	pkey = kmemdup(key, keylen, GFP_ATOMIC);
 	if (!pkey)
 		return -ENOMEM;
 
 	spin_lock(&vcrypto->ctrl_lock);
-	memcpy(&vcrypto->ctrl.header, header, sizeof(vcrypto->ctrl.header));
-	memcpy(&vcrypto->ctrl.u, para, sizeof(vcrypto->ctrl.u));
-	vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
+	ctrl = &vcrypto->ctrl;
+	memcpy(&ctrl->header, header, sizeof(ctrl->header));
+	memcpy(&ctrl->u, para, sizeof(ctrl->u));
+	input = &vcrypto->input;
+	input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
 
-	sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sg_init_one(&outhdr_sg, ctrl, sizeof(*ctrl));
 	sgs[num_out++] = &outhdr_sg;
 
 	sg_init_one(&key_sg, pkey, keylen);
 	sgs[num_out++] = &key_sg;
 
-	sg_init_one(&inhdr_sg, &vcrypto->input, sizeof(vcrypto->input));
+	sg_init_one(&inhdr_sg, input, sizeof(*input));
 	sgs[num_out + num_in++] = &inhdr_sg;
 
 	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
@@ -134,12 +138,12 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
 	       !virtqueue_is_broken(vcrypto->ctrl_vq))
 		cpu_relax();
 
-	if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
+	if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
 		err = -EINVAL;
 		goto out;
 	}
 
-	ctx->session_id = le64_to_cpu(vcrypto->input.session_id);
+	ctx->session_id = le64_to_cpu(input->session_id);
 	ctx->session_valid = true;
 	err = 0;
 
@@ -149,7 +153,7 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
 
 	if (err < 0)
 		pr_err("virtio_crypto: Create session failed status: %u\n",
-			le32_to_cpu(vcrypto->input.status));
+			le32_to_cpu(input->status));
 
 	return err;
 }
@@ -161,23 +165,27 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	unsigned int num_out = 0, num_in = 0, inlen;
 	int err;
+	struct virtio_crypto_op_ctrl_req *ctrl;
+	struct virtio_crypto_inhdr *ctrl_status;
 
 	spin_lock(&vcrypto->ctrl_lock);
 	if (!ctx->session_valid) {
 		err = 0;
 		goto out;
 	}
-	vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
-	vcrypto->ctrl.header.opcode = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
-	vcrypto->ctrl.header.queue_id = 0;
+	ctrl_status = &vcrypto->ctrl_status;
+	ctrl_status->status = VIRTIO_CRYPTO_ERR;
+	ctrl = &vcrypto->ctrl;
+	ctrl->header.opcode = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
+	ctrl->header.queue_id = 0;
 
-	destroy_session = &vcrypto->ctrl.u.destroy_session;
+	destroy_session = &ctrl->u.destroy_session;
 	destroy_session->session_id = cpu_to_le64(ctx->session_id);
 
-	sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sg_init_one(&outhdr_sg, ctrl, sizeof(*ctrl));
 	sgs[num_out++] = &outhdr_sg;
 
-	sg_init_one(&inhdr_sg, &vcrypto->ctrl_status.status, sizeof(vcrypto->ctrl_status.status));
+	sg_init_one(&inhdr_sg, &ctrl_status->status, sizeof(ctrl_status->status));
 	sgs[num_out + num_in++] = &inhdr_sg;
 
 	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
@@ -189,7 +197,7 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
 	       !virtqueue_is_broken(vcrypto->ctrl_vq))
 		cpu_relax();
 
-	if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
+	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
 		err = -EINVAL;
 		goto out;
 	}
@@ -201,7 +209,7 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
 	spin_unlock(&vcrypto->ctrl_lock);
 	if (err < 0) {
 		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
-			vcrypto->ctrl_status.status, destroy_session->session_id);
+			ctrl_status->status, destroy_session->session_id);
 	}
 
 	return err;
diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
index a618c46a52b8..e3c5bc8d6112 100644
--- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
@@ -123,6 +123,9 @@ static int virtio_crypto_alg_skcipher_init_session(
 	int op = encrypt ? VIRTIO_CRYPTO_OP_ENCRYPT : VIRTIO_CRYPTO_OP_DECRYPT;
 	int err;
 	unsigned int num_out = 0, num_in = 0;
+	struct virtio_crypto_op_ctrl_req *ctrl;
+	struct virtio_crypto_session_input *input;
+	struct virtio_crypto_sym_create_session_req *sym_create_session;
 
 	/*
 	 * Avoid to do DMA from the stack, switch to using
@@ -135,24 +138,22 @@ static int virtio_crypto_alg_skcipher_init_session(
 
 	spin_lock(&vcrypto->ctrl_lock);
 	/* Pad ctrl header */
-	vcrypto->ctrl.header.opcode =
-		cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
-	vcrypto->ctrl.header.algo = cpu_to_le32(alg);
+	ctrl = &vcrypto->ctrl;
+	ctrl->header.opcode = cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
+	ctrl->header.algo = cpu_to_le32(alg);
 	/* Set the default dataqueue id to 0 */
-	vcrypto->ctrl.header.queue_id = 0;
+	ctrl->header.queue_id = 0;
 
-	vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
+	input = &vcrypto->input;
+	input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
 	/* Pad cipher's parameters */
-	vcrypto->ctrl.u.sym_create_session.op_type =
-		cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
-	vcrypto->ctrl.u.sym_create_session.u.cipher.para.algo =
-		vcrypto->ctrl.header.algo;
-	vcrypto->ctrl.u.sym_create_session.u.cipher.para.keylen =
-		cpu_to_le32(keylen);
-	vcrypto->ctrl.u.sym_create_session.u.cipher.para.op =
-		cpu_to_le32(op);
-
-	sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sym_create_session = &ctrl->u.sym_create_session;
+	sym_create_session->op_type = cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
+	sym_create_session->u.cipher.para.algo = ctrl->header.algo;
+	sym_create_session->u.cipher.para.keylen = cpu_to_le32(keylen);
+	sym_create_session->u.cipher.para.op = cpu_to_le32(op);
+
+	sg_init_one(&outhdr, ctrl, sizeof(*ctrl));
 	sgs[num_out++] = &outhdr;
 
 	/* Set key */
@@ -160,7 +161,7 @@ static int virtio_crypto_alg_skcipher_init_session(
 	sgs[num_out++] = &key_sg;
 
 	/* Return status and session id back */
-	sg_init_one(&inhdr, &vcrypto->input, sizeof(vcrypto->input));
+	sg_init_one(&inhdr, input, sizeof(*input));
 	sgs[num_out + num_in++] = &inhdr;
 
 	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
@@ -180,20 +181,18 @@ static int virtio_crypto_alg_skcipher_init_session(
 	       !virtqueue_is_broken(vcrypto->ctrl_vq))
 		cpu_relax();
 
-	if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
+	if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
 		spin_unlock(&vcrypto->ctrl_lock);
 		pr_err("virtio_crypto: Create session failed status: %u\n",
-			le32_to_cpu(vcrypto->input.status));
+			le32_to_cpu(input->status));
 		kfree_sensitive(cipher_key);
 		return -EINVAL;
 	}
 
 	if (encrypt)
-		ctx->enc_sess_info.session_id =
-			le64_to_cpu(vcrypto->input.session_id);
+		ctx->enc_sess_info.session_id = le64_to_cpu(input->session_id);
 	else
-		ctx->dec_sess_info.session_id =
-			le64_to_cpu(vcrypto->input.session_id);
+		ctx->dec_sess_info.session_id = le64_to_cpu(input->session_id);
 
 	spin_unlock(&vcrypto->ctrl_lock);
 
@@ -211,30 +210,30 @@ static int virtio_crypto_alg_skcipher_close_session(
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	int err;
 	unsigned int num_out = 0, num_in = 0;
+	struct virtio_crypto_op_ctrl_req *ctrl;
+	struct virtio_crypto_inhdr *ctrl_status;
 
 	spin_lock(&vcrypto->ctrl_lock);
-	vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
+	ctrl_status = &vcrypto->ctrl_status;
+	ctrl_status->status = VIRTIO_CRYPTO_ERR;
 	/* Pad ctrl header */
-	vcrypto->ctrl.header.opcode =
-		cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
+	ctrl = &vcrypto->ctrl;
+	ctrl->header.opcode = cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
 	/* Set the default virtqueue id to 0 */
-	vcrypto->ctrl.header.queue_id = 0;
+	ctrl->header.queue_id = 0;
 
-	destroy_session = &vcrypto->ctrl.u.destroy_session;
+	destroy_session = &ctrl->u.destroy_session;
 
 	if (encrypt)
-		destroy_session->session_id =
-			cpu_to_le64(ctx->enc_sess_info.session_id);
+		destroy_session->session_id = cpu_to_le64(ctx->enc_sess_info.session_id);
 	else
-		destroy_session->session_id =
-			cpu_to_le64(ctx->dec_sess_info.session_id);
+		destroy_session->session_id = cpu_to_le64(ctx->dec_sess_info.session_id);
 
-	sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sg_init_one(&outhdr, ctrl, sizeof(*ctrl));
 	sgs[num_out++] = &outhdr;
 
 	/* Return status and session id back */
-	sg_init_one(&status_sg, &vcrypto->ctrl_status.status,
-		sizeof(vcrypto->ctrl_status.status));
+	sg_init_one(&status_sg, &ctrl_status->status, sizeof(ctrl_status->status));
 	sgs[num_out + num_in++] = &status_sg;
 
 	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
@@ -249,11 +248,10 @@ static int virtio_crypto_alg_skcipher_close_session(
 	       !virtqueue_is_broken(vcrypto->ctrl_vq))
 		cpu_relax();
 
-	if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
+	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
 		spin_unlock(&vcrypto->ctrl_lock);
 		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
-			vcrypto->ctrl_status.status,
-			destroy_session->session_id);
+			ctrl_status->status, destroy_session->session_id);
 
 		return -EINVAL;
 	}
-- 
2.20.1

