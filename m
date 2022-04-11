Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8674FB28D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 06:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244590AbiDKENU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 00:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243357AbiDKENN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 00:13:13 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628455FB4;
        Sun, 10 Apr 2022 21:10:59 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id n11so1511905qvl.0;
        Sun, 10 Apr 2022 21:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=T3DTfN/edOrVxnFEM6SHHqTv2+rBmdqTYXOOB4R9haY=;
        b=IXCk9bdwhlFdQuVJu2gotWZhLdkKRAWdITlHQYjd0v+MckfvQU8CtkAjhbq8dQOEmX
         szapVWjQktO7xxyF3oVifPcLqZiyngATEdxthQsV7363LJuG0Kdv0QRFw0xqrNFjTLm1
         3a5w/NEbATzkxv2OfQsjptG6rJRTdKY4CwRTqiICTsGTyow/qzA5m6M2pOgofWgRlDuw
         teBgERL3+KUQmk2f4aWXkQqunxZMbiZE0MYgPyroEsOmEmGq5hqub2b7tXXBHIy3bLZi
         dwCoN28mHr7Io3vbr1Fs2PKEalI9RmSpGpSydltNhFJdkzR9Qp5mdqOdm6owRySCQ29X
         e++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=T3DTfN/edOrVxnFEM6SHHqTv2+rBmdqTYXOOB4R9haY=;
        b=XT9yeF3NdhSS7G8sdwe+tuQA/KRP0p64Y+ccBJa9NVR0j4Knya/yqeuHM6kFcIlq27
         jThmOhiA5qAKTHQs3SXmg5jfT8xLcbS0nCcbzAtNwCvNK5abh5ZK65B+14ze7dxowqEJ
         P2ueriQ+qDqiwaVj7I+fBXFudh7mB4yYkHywQSoGLJliMQALgcvvIM0gsQKjuy/ERfJK
         1kCRu5DpsFDNIhitSSL3+5JBoHHXlFAnBQnmrO7FlY6byHKBs8xKznqOL6uF3Ouk7w5d
         zFU8C8PdyCf5pL/d+6JhnvPKB++zJ097CU/xPvYV8ayS9KJnpy4SG/zmX2FebcLIvtgo
         hBGw==
X-Gm-Message-State: AOAM530ONMd/Qovy/ydgLNDNqdoYgPzG6cmwhMvUlOSDW9hZnrrlwQPH
        ppub14Mngf6PpJBhAI+/q2M=
X-Google-Smtp-Source: ABdhPJwSc1xEcKIVIx6YeN3QR2339n8x8xgMIPlUuFbzDSmEeL8eds62kzVGfgbf7j0HmXRjtPRI8g==
X-Received: by 2002:a05:6214:da2:b0:441:4623:945c with SMTP id h2-20020a0562140da200b004414623945cmr24703292qvh.62.1649650258511;
        Sun, 10 Apr 2022 21:10:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:91e2:dfcf:c904:aebc? ([2600:1700:2442:6db0:91e2:dfcf:c904:aebc])
        by smtp.gmail.com with ESMTPSA id d11-20020a37680b000000b0069ab73d9981sm6317610qkc.38.2022.04.10.21.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 21:10:58 -0700 (PDT)
Message-ID: <bcc7cbbb-eb5c-d089-31aa-efdd4868a177@gmail.com>
Date:   Sun, 10 Apr 2022 23:10:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] of: overlay: rename variables to be consistent
Content-Language: en-US
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
References: <20220410210833.441504-1-frowand.list@gmail.com>
 <20220410210833.441504-2-frowand.list@gmail.com>
In-Reply-To: <20220410210833.441504-2-frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adding cc: Jan Kiszka <jan.kiszka@siemens.com>

On 4/10/22 16:08, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Variables change name across function calls when there is not a good
> reason to do so.  Fix by changing "fdt" to "new_fdt" and "tree" to
> "overlay_tree".
> 
> The name disparity was confusing when creating the following commit.
> The name changes are in this separate commit to make review of the
> following commmit less complex.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> Changes since v1:
>   - This patch is added to the series.
> 
>  drivers/of/overlay.c | 94 ++++++++++++++++++++++----------------------
>  1 file changed, 47 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index d80160cf34bb..f74aa9ff67aa 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -57,7 +57,7 @@ struct fragment {
>   * struct overlay_changeset
>   * @id:			changeset identifier
>   * @ovcs_list:		list on which we are located
> - * @fdt:		base of memory allocated to hold aligned FDT that was unflattened to create @overlay_tree
> + * @new_fdt:		Memory allocated to hold unflattened aligned FDT
>   * @overlay_tree:	expanded device tree that contains the fragment nodes
>   * @count:		count of fragment structures
>   * @fragments:		fragment nodes in the overlay expanded device tree
> @@ -67,7 +67,7 @@ struct fragment {
>  struct overlay_changeset {
>  	int id;
>  	struct list_head ovcs_list;
> -	const void *fdt;
> +	const void *new_fdt;
>  	struct device_node *overlay_tree;
>  	int count;
>  	struct fragment *fragments;
> @@ -718,19 +718,20 @@ static struct device_node *find_target(struct device_node *info_node)
>  
>  /**
>   * init_overlay_changeset() - initialize overlay changeset from overlay tree
> - * @ovcs:	Overlay changeset to build
> - * @fdt:	base of memory allocated to hold aligned FDT that was unflattened to create @tree
> - * @tree:	Contains the overlay fragments and overlay fixup nodes
> + * @ovcs:		Overlay changeset to build
> + * @new_fdt:		Memory allocated to hold unflattened aligned FDT
> + * @overlay_tree:	Contains the overlay fragments and overlay fixup nodes
>   *
>   * Initialize @ovcs.  Populate @ovcs->fragments with node information from
> - * the top level of @tree.  The relevant top level nodes are the fragment
> - * nodes and the __symbols__ node.  Any other top level node will be ignored.
> + * the top level of @overlay_tree.  The relevant top level nodes are the
> + * fragment nodes and the __symbols__ node.  Any other top level node will
> + * be ignored.
>   *
>   * Return: 0 on success, -ENOMEM if memory allocation failure, -EINVAL if error
> - * detected in @tree, or -ENOSPC if idr_alloc() error.
> + * detected in @overlay_tree, or -ENOSPC if idr_alloc() error.
>   */
>  static int init_overlay_changeset(struct overlay_changeset *ovcs,
> -		const void *fdt, struct device_node *tree)
> +		const void *new_fdt, struct device_node *overlay_tree)
>  {
>  	struct device_node *node, *overlay_node;
>  	struct fragment *fragment;
> @@ -741,17 +742,17 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
>  	 * Warn for some issues.  Can not return -EINVAL for these until
>  	 * of_unittest_apply_overlay() is fixed to pass these checks.
>  	 */
> -	if (!of_node_check_flag(tree, OF_DYNAMIC))
> -		pr_debug("%s() tree is not dynamic\n", __func__);
> +	if (!of_node_check_flag(overlay_tree, OF_DYNAMIC))
> +		pr_debug("%s() overlay_tree is not dynamic\n", __func__);
>  
> -	if (!of_node_check_flag(tree, OF_DETACHED))
> -		pr_debug("%s() tree is not detached\n", __func__);
> +	if (!of_node_check_flag(overlay_tree, OF_DETACHED))
> +		pr_debug("%s() overlay_tree is not detached\n", __func__);
>  
> -	if (!of_node_is_root(tree))
> -		pr_debug("%s() tree is not root\n", __func__);
> +	if (!of_node_is_root(overlay_tree))
> +		pr_debug("%s() overlay_tree is not root\n", __func__);
>  
> -	ovcs->overlay_tree = tree;
> -	ovcs->fdt = fdt;
> +	ovcs->overlay_tree = overlay_tree;
> +	ovcs->new_fdt = new_fdt;
>  
>  	INIT_LIST_HEAD(&ovcs->ovcs_list);
>  
> @@ -764,7 +765,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
>  	cnt = 0;
>  
>  	/* fragment nodes */
> -	for_each_child_of_node(tree, node) {
> +	for_each_child_of_node(overlay_tree, node) {
>  		overlay_node = of_get_child_by_name(node, "__overlay__");
>  		if (overlay_node) {
>  			cnt++;
> @@ -772,7 +773,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
>  		}
>  	}
>  
> -	node = of_get_child_by_name(tree, "__symbols__");
> +	node = of_get_child_by_name(overlay_tree, "__symbols__");
>  	if (node) {
>  		cnt++;
>  		of_node_put(node);
> @@ -785,7 +786,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
>  	}
>  
>  	cnt = 0;
> -	for_each_child_of_node(tree, node) {
> +	for_each_child_of_node(overlay_tree, node) {
>  		overlay_node = of_get_child_by_name(node, "__overlay__");
>  		if (!overlay_node)
>  			continue;
> @@ -807,7 +808,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
>  	 * if there is a symbols fragment in ovcs->fragments[i] it is
>  	 * the final element in the array
>  	 */
> -	node = of_get_child_by_name(tree, "__symbols__");
> +	node = of_get_child_by_name(overlay_tree, "__symbols__");
>  	if (node) {
>  		ovcs->symbols_fragment = 1;
>  		fragment = &fragments[cnt];
> @@ -862,11 +863,11 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>  	kfree(ovcs->fragments);
>  	/*
>  	 * There should be no live pointers into ovcs->overlay_tree and
> -	 * ovcs->fdt due to the policy that overlay notifiers are not allowed
> -	 * to retain pointers into the overlay devicetree.
> +	 * ovcs->new_fdt due to the policy that overlay notifiers are not
> +	 * allowed to retain pointers into the overlay devicetree.
>  	 */
>  	kfree(ovcs->overlay_tree);
> -	kfree(ovcs->fdt);
> +	kfree(ovcs->new_fdt);
>  	kfree(ovcs);
>  }
>  
> @@ -874,16 +875,15 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>   * internal documentation
>   *
>   * of_overlay_apply() - Create and apply an overlay changeset
> - * @fdt:	base of memory allocated to hold the aligned FDT
> - * @tree:	Expanded overlay device tree
> - * @ovcs_id:	Pointer to overlay changeset id
> + * @new_fdt:		Memory allocated to hold the aligned FDT
> + * @overlay_tree:	Expanded overlay device tree
> + * @ovcs_id:		Pointer to overlay changeset id
>   *
>   * Creates and applies an overlay changeset.
>   *
>   * If an error occurs in a pre-apply notifier, then no changes are made
>   * to the device tree.
>   *
> -
>   * A non-zero return value will not have created the changeset if error is from:
>   *   - parameter checks
>   *   - building the changeset
> @@ -913,29 +913,29 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>   * id is returned to *ovcs_id.
>   */
>  
> -static int of_overlay_apply(const void *fdt, struct device_node *tree,
> -		int *ovcs_id)
> +static int of_overlay_apply(const void *new_fdt,
> +		struct device_node *overlay_tree, int *ovcs_id)
>  {
>  	struct overlay_changeset *ovcs;
>  	int ret = 0, ret_revert, ret_tmp;
>  
>  	/*
> -	 * As of this point, fdt and tree belong to the overlay changeset.
> -	 * overlay changeset code is responsible for freeing them.
> +	 * As of this point, new_fdt and overlay_tree belong to the overlay
> +	 * changeset.  overlay changeset code is responsible for freeing them.
>  	 */
>  
>  	if (devicetree_corrupt()) {
>  		pr_err("devicetree state suspect, refuse to apply overlay\n");
> -		kfree(fdt);
> -		kfree(tree);
> +		kfree(new_fdt);
> +		kfree(overlay_tree);
>  		ret = -EBUSY;
>  		goto out;
>  	}
>  
>  	ovcs = kzalloc(sizeof(*ovcs), GFP_KERNEL);
>  	if (!ovcs) {
> -		kfree(fdt);
> -		kfree(tree);
> +		kfree(new_fdt);
> +		kfree(overlay_tree);
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> @@ -943,20 +943,20 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>  	of_overlay_mutex_lock();
>  	mutex_lock(&of_mutex);
>  
> -	ret = of_resolve_phandles(tree);
> +	ret = of_resolve_phandles(overlay_tree);
>  	if (ret)
> -		goto err_free_tree;
> +		goto err_free_overlay_tree;
>  
> -	ret = init_overlay_changeset(ovcs, fdt, tree);
> +	ret = init_overlay_changeset(ovcs, new_fdt, overlay_tree);
>  	if (ret)
> -		goto err_free_tree;
> +		goto err_free_overlay_tree;
>  
>  	/*
>  	 * after overlay_notify(), ovcs->overlay_tree related pointers may have
> -	 * leaked to drivers, so can not kfree() tree, aka ovcs->overlay_tree;
> -	 * and can not free memory containing aligned fdt.  The aligned fdt
> -	 * is contained within the memory at ovcs->fdt, possibly at an offset
> -	 * from ovcs->fdt.
> +	 * leaked to drivers, so can not kfree() overlay_tree,
> +	 * aka ovcs->overlay_tree; and can not free memory containing aligned
> +	 * fdt.  The aligned fdt is contained within the memory at
> +	 * ovcs->new_fdt, possibly at an offset from ovcs->new_fdt.
>  	 */
>  	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
>  	if (ret) {
> @@ -997,9 +997,9 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>  
>  	goto out_unlock;
>  
> -err_free_tree:
> -	kfree(fdt);
> -	kfree(tree);
> +err_free_overlay_tree:
> +	kfree(new_fdt);
> +	kfree(overlay_tree);
>  
>  err_free_overlay_changeset:
>  	free_overlay_changeset(ovcs);

