Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B90C506077
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbiDSAFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbiDSAFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:05:13 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F54913F72;
        Mon, 18 Apr 2022 17:02:32 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id d198so9210371qkc.12;
        Mon, 18 Apr 2022 17:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=v5sAQPoz+4FlzueXp8SXFkNOGGYIN8UB+hEuhkWu+Hc=;
        b=jvy6DcT9tWfsQGFyUZN/7pF5uBpj+AsxOem8n3tGiQcA/obSMJeEt+m08FkvhEUImS
         nIutNg1clxnwhuAMqnYljAZe4grHFfmf99QG8on3v9BSzBLH5IvoVdMoi5I6/8gSnyrm
         +yNRJ9GSvbCfAcl37KyIH2yzbVMrH5ZnEgv/FkBozX8EYufD1c/1S7UhC9VPPqSqex9E
         rWKOboeKLJjcdodOOpjfxn1vcrlBhyhhk4/axHgiGHGkL/3z8S9jG/R2A3Pbsljk2Gcl
         jpnVD+7ckAcm32Njkoc3J9IuHP0FKBT3q3TyMwynyT9gt1woHNlbYuwllV9NGnsK9zD6
         MAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=v5sAQPoz+4FlzueXp8SXFkNOGGYIN8UB+hEuhkWu+Hc=;
        b=pKBCeRV3lmmK5M2+7lp96LxHLocZTpEEutZBGWOBCeJuTkQpzjOFHAxg8xNy+Fcbmb
         ffCOEsDi3YgZE23XB3MSL0z8UwpJhWdCJ8pkV7A8ZQmJHOJxJHKgpkpCisewmR/F6HYh
         eTDYJwVRwDxrnbJXrlgQf7TP+5JjFkZacB454ml7NVC50/4bsFKXKGsE3J7tM8aXuYnN
         a9J/USsLVeeaHlezT12yAExe3nkXKfjUVQ1pIf0LyetCfNerBkg3I14wejTbsCOXz3ek
         FTrZJ/BUCqqosutI0uT0kyi3XPaHFdfNkk9mdgzoJxtoOOk4J7uZLRLeJ2EHvl5cL8vW
         llrw==
X-Gm-Message-State: AOAM531NWzK6MJ8XCwwTCbQ+vTBSUTsWFkGZbU+tvmOKA0chFegbBKZ3
        Va9/iLu9bxfJtFee+1Ny10U=
X-Google-Smtp-Source: ABdhPJxtayrl627FiRddPMR2UUSSdtlPXaDoUIGq1yFsXNfkHOFwWJd1xLXGAZojbekC0mYk1b1FQQ==
X-Received: by 2002:a05:620a:46ac:b0:69c:2b60:d72e with SMTP id bq44-20020a05620a46ac00b0069c2b60d72emr8353305qkb.36.1650326551296;
        Mon, 18 Apr 2022 17:02:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:75b4:bbab:3658:5e82? ([2600:1700:2442:6db0:75b4:bbab:3658:5e82])
        by smtp.gmail.com with ESMTPSA id x24-20020ae9f818000000b0069eadcdc218sm1308679qkh.135.2022.04.18.17.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 17:02:30 -0700 (PDT)
Message-ID: <8f65a734-1c2f-023e-79db-1a98d8f1b456@gmail.com>
Date:   Mon, 18 Apr 2022 19:02:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] of: overlay: rework overlay apply and remove
 kfree()s
Content-Language: en-US
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Slawomir Stepien <sst@poczta.fm>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
References: <20220410210833.441504-1-frowand.list@gmail.com>
 <20220410210833.441504-3-frowand.list@gmail.com>
 <CAL_JsqJSerSHR_p-zPiEO_uzFrRF_=mOPtKFdGWD-OCt7WqLDQ@mail.gmail.com>
 <400ab321-99fc-9669-c277-007906a9cc14@gmail.com>
In-Reply-To: <400ab321-99fc-9669-c277-007906a9cc14@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 4/12/22 12:20, Frank Rowand wrote:
> On 4/12/22 09:00, Rob Herring wrote:
>>   On Sun, Apr 10, 2022 at 4:08 PM <frowand.list@gmail.com> wrote:
>>>
>>> From: Frank Rowand <frank.rowand@sony.com>
>>>
>>> Fix various kfree() issues related to of_overlay_apply().
>>>   - Double kfree() of fdt and tree when init_overlay_changeset()
>>>     returns an error.
>>>   - free_overlay_changeset() free the root of the unflattened
>>>     overlay (variable tree) instead of the memory that contains
>>>     the unflattened overlay.
>>>   - For the case of a failure during applying an overlay, move kfree()
>>>     of new_fdt and overlay_mem into the function that allocated them.
>>>     For the case of removing an overlay, the kfree() remains in
>>>     free_overlay_changeset().
>>>   - Check return value of of_fdt_unflatten_tree() for error instead
>>>     of checking the returnded value of overlay_root.
>>>
>>> More clearly document policy related to lifetime of pointers into
>>> overlay memory.
>>>
>>> Double kfree()
>>> Reported-by: Slawomir Stepien <slawomir.stepien@nokia.com>
>>>
>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>> ---
>>>
>>> Changes since v1:
>>>   - Move kfree()s from init_overlay_changeset() to of_overlay_fdt_apply()
>>>   - Better document lifetime of pointers into overlay, both in overlay.c
>>>     and Documentation/devicetree/overlay-notes.rst
>>>
>>>  Documentation/devicetree/overlay-notes.rst |  23 +++-
>>>  drivers/of/overlay.c                       | 127 ++++++++++++---------
>>>  2 files changed, 91 insertions(+), 59 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/overlay-notes.rst b/Documentation/devicetree/overlay-notes.rst
>>> index b2b8db765b8c..7a6e85f75567 100644
>>> --- a/Documentation/devicetree/overlay-notes.rst
>>> +++ b/Documentation/devicetree/overlay-notes.rst
>>> @@ -119,10 +119,25 @@ Finally, if you need to remove all overlays in one-go, just call
>>>  of_overlay_remove_all() which will remove every single one in the correct
>>>  order.
>>>
>>> -In addition, there is the option to register notifiers that get called on
>>> +There is the option to register notifiers that get called on
>>>  overlay operations. See of_overlay_notifier_register/unregister and
>>>  enum of_overlay_notify_action for details.
>>>
>>> -Note that a notifier callback is not supposed to store pointers to a device
>>> -tree node or its content beyond OF_OVERLAY_POST_REMOVE corresponding to the
>>> -respective node it received.
>>> +A notifier callback for OF_OVERLAY_PRE_APPLY, OF_OVERLAY_POST_APPLY, or
>>> +OF_OVERLAY_PRE_REMOVE may store pointers to a device tree node in the overlay
>>> +or its content but these pointers must not persist past the notifier callback
>>> +for OF_OVERLAY_POST_REMOVE.  The memory containing the overlay will be
>>> +kfree()ed after OF_OVERLAY_POST_REMOVE notifiers are called.  Note that the
>>> +memory will be kfree()ed even if the notifier for OF_OVERLAY_POST_REMOVE
>>> +returns an error.
>>> +
>>> +The changeset notifiers in drivers/of/dynamic.c are a second type of notifier
>>> +that could be triggered by applying or removing an overlay.  These notifiers
>>> +are not allowed to store pointers to a device tree node in the overlay
>>> +or its content.  The overlay code does not protect against such pointers
>>> +remaining active when the memory containing the overlay is freed as a result
>>> +of removing the overlay.
>>> +
>>> +Any other code that retains a pointer to the overlay nodes or data is
>>> +considered to be a bug because after removing the overlay the pointer
>>> +will refer to freed memory.
>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>>> index f74aa9ff67aa..c8e999518f2f 100644
>>> --- a/drivers/of/overlay.c
>>> +++ b/drivers/of/overlay.c
>>> @@ -58,6 +58,7 @@ struct fragment {
>>>   * @id:                        changeset identifier
>>>   * @ovcs_list:         list on which we are located
>>>   * @new_fdt:           Memory allocated to hold unflattened aligned FDT
>>> + * @overlay_mem:       the memory chunk that contains @overlay_tree
>>>   * @overlay_tree:      expanded device tree that contains the fragment nodes
>>>   * @count:             count of fragment structures
>>>   * @fragments:         fragment nodes in the overlay expanded device tree
>>> @@ -68,6 +69,7 @@ struct overlay_changeset {
>>>         int id;
>>>         struct list_head ovcs_list;
>>>         const void *new_fdt;
>>> +       const void *overlay_mem;
>>>         struct device_node *overlay_tree;
>>>         int count;
>>>         struct fragment *fragments;
>>> @@ -720,18 +722,20 @@ static struct device_node *find_target(struct device_node *info_node)
>>>   * init_overlay_changeset() - initialize overlay changeset from overlay tree
>>>   * @ovcs:              Overlay changeset to build
>>>   * @new_fdt:           Memory allocated to hold unflattened aligned FDT
>>> + * @tree_mem:          Memory that contains @overlay_tree
>>>   * @overlay_tree:      Contains the overlay fragments and overlay fixup nodes
>>>   *
>>>   * Initialize @ovcs.  Populate @ovcs->fragments with node information from
>>>   * the top level of @overlay_tree.  The relevant top level nodes are the
>>>   * fragment nodes and the __symbols__ node.  Any other top level node will
>>> - * be ignored.
>>> + * be ignored.  Populate other @ovcs fields.
>>>   *
>>>   * Return: 0 on success, -ENOMEM if memory allocation failure, -EINVAL if error
>>>   * detected in @overlay_tree, or -ENOSPC if idr_alloc() error.
>>>   */
>>>  static int init_overlay_changeset(struct overlay_changeset *ovcs,
>>> -               const void *new_fdt, struct device_node *overlay_tree)
>>> +               const void *new_fdt, const void *tree_mem,
>>> +               struct device_node *overlay_tree)
>>>  {
>>>         struct device_node *node, *overlay_node;
>>>         struct fragment *fragment;
>>> @@ -751,9 +755,6 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
>>>         if (!of_node_is_root(overlay_tree))
>>>                 pr_debug("%s() overlay_tree is not root\n", __func__);
>>>
>>> -       ovcs->overlay_tree = overlay_tree;
>>> -       ovcs->new_fdt = new_fdt;
>>> -
>>>         INIT_LIST_HEAD(&ovcs->ovcs_list);
>>>
>>>         of_changeset_init(&ovcs->cset);
>>> @@ -832,6 +833,9 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
>>>
>>>         ovcs->id = id;
>>>         ovcs->count = cnt;
>>> +       ovcs->new_fdt = new_fdt;
>>> +       ovcs->overlay_mem = tree_mem;
>>> +       ovcs->overlay_tree = overlay_tree;
>>>         ovcs->fragments = fragments;
>>>
>>>         return 0;
>>> @@ -846,7 +850,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
>>>         return ret;
>>>  }
>>>
>>> -static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>> +static void free_overlay_changeset_contents(struct overlay_changeset *ovcs)
>>>  {
>>>         int i;
>>>
>>> @@ -861,12 +865,20 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>>                 of_node_put(ovcs->fragments[i].overlay);
>>>         }
>>>         kfree(ovcs->fragments);
>>> +}
>>> +static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>> +{
>>> +
>>> +       free_overlay_changeset_contents(ovcs);
>>> +
>>>         /*
>>> -        * There should be no live pointers into ovcs->overlay_tree and
>>> +        * There should be no live pointers into ovcs->overlay_mem and
>>>          * ovcs->new_fdt due to the policy that overlay notifiers are not
>>> -        * allowed to retain pointers into the overlay devicetree.
>>> +        * allowed to retain pointers into the overlay devicetree other
>>> +        * than the window between OF_OVERLAY_PRE_APPLY overlay notifiers
>>> +        * and the OF_OVERLAY_POST_REMOVE overlay notifiers.
>>>          */
>>> -       kfree(ovcs->overlay_tree);
>>> +       kfree(ovcs->overlay_mem);
>>>         kfree(ovcs->new_fdt);
>>>         kfree(ovcs);
>>>  }
>>> @@ -876,8 +888,10 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>>   *
>>>   * of_overlay_apply() - Create and apply an overlay changeset
>>>   * @new_fdt:           Memory allocated to hold the aligned FDT
>>> + * @tree_mem:          Memory that contains @overlay_tree
>>>   * @overlay_tree:      Expanded overlay device tree
>>>   * @ovcs_id:           Pointer to overlay changeset id
>>> + * @kfree_unsafe:      Pointer to flag to not kfree() @new_fdt and @overlay_tree
>>
>> This screams hack.
> 
> I agree that it screams hack.
> 
>>
>> It would be somewhat less hacky if we stored some state information in
>> ovcs struct that conveys the apply state of the overlay and then used
>> that to determine if we should do kfree or not.
> 
> I tried this approach first, and thought the result was rather ugly.  But
> it is possible if you prefer.  If the state was stored in ovcs, then
> the kfree() code at the end of of_overlay_fdt_apply() would change from:
> 
> 
> out_free_overlay_mem:
>         if (!kfree_unsafe)
>                 kfree(overlay_mem);
> 
> out_free_new_fdt:
>         if (!kfree_unsafe)
>                 kfree(new_fdt);
> 
>         return ret;
> 
> 
> to something like (untested, thrown together):
> 
> 
> out_free_overlay_mem:
>         mutex_lock(&of_mutex);
> 
>         ovcs = idr_find(&ovcs_idr, *ovcs_id);
>         if (!ovcs) {
>                 ret = -ENODEV;
>                 pr_err("remove: Could not find overlay #%d for kfree(overlay_mem)\n", *ovcs_id);
>                 goto out_unlock;
>         }
> 
>         if (!ovcs->kfree_unsafe)
>                 kfree(overlay_mem);
> 
>         mutex_unlock(&of_mutex);
> 
> out_free_new_fdt:
>         mutex_lock(&of_mutex); 
> 
>         ovcs = idr_find(&ovcs_idr, *ovcs_id);
>         if (!ovcs) {
>                 ret = -ENODEV;
>                 pr_err("remove: Could not find overlay #%d for kfree(new_fdt)\n", *ovcs_id);
>                 goto out_unlock;
>         }
> 
>         if (!ovcs->kfree_unsafe)
>                 kfree(new_fdt);
> 
> out_unlock:
>         mutex_unlock(&of_mutex);
> 
>         return ret;
> 
> 
> The upside is that new_fdt and overlay_mem would no longer be arguments to
> of_overlay_apply() and its children.

So that chunk above was obviously not the nicest way to implement, but it
gave me the push to accomplish the same result but cleanly.

Patch v3 is coming, much improved thanks to your comments.

-Frank

> 
>>
>> Perhaps a better fix would be refcounting the overlay as a whole and
>> freeing everything when the refcount goes to 0.
> 
> We already know when the overlay as a whole is no longer referenced -- it
> is when of_overlay_remove() is successful.  The refcount would instead be
> on new_fdt and overlay_mem.  But the location of incrementing the refcount
> is in of_overlay_apply() and its children, so the ugliness of passing
> new_fdt and overlay_mem into those functions remains.
> 
> I am fine with the "hacky" approach or the saving more state in ovcs.  I
> would prefer not to use the refcount approach.
> 
> If the "hacky" approach is used, I would do a v3 that adds an additional
> comment in of_overlay_remove() that describes the window in that function
> where a memory leak can still occur.
> 
>>
>>>   *
>>>   * Creates and applies an overlay changeset.
>>>   *
>>> @@ -910,34 +924,25 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>>   * refused.
>>>   *
>>>   * Returns 0 on success, or a negative error number.  Overlay changeset
>>> - * id is returned to *ovcs_id.
>>> + * id is returned to *ovcs_id.  When references to @new_fdt and @overlay_tree
>>> + * may exist, *kfree_unsafe is set to true.
>>>   */
>>>
>>> -static int of_overlay_apply(const void *new_fdt,
>>> -               struct device_node *overlay_tree, int *ovcs_id)
>>> +static int of_overlay_apply(const void *new_fdt, void *tree_mem,
>>> +               struct device_node *overlay_tree, int *ovcs_id,
>>> +               bool *kfree_unsafe)
>>>  {
>>>         struct overlay_changeset *ovcs;
>>>         int ret = 0, ret_revert, ret_tmp;
>>>
>>> -       /*
>>> -        * As of this point, new_fdt and overlay_tree belong to the overlay
>>> -        * changeset.  overlay changeset code is responsible for freeing them.
>>> -        */
>>> -
>>>         if (devicetree_corrupt()) {
>>>                 pr_err("devicetree state suspect, refuse to apply overlay\n");
>>> -               kfree(new_fdt);
>>> -               kfree(overlay_tree);
>>> -               ret = -EBUSY;
>>> -               goto out;
>>> +               return -EBUSY;
>>>         }
>>>
>>>         ovcs = kzalloc(sizeof(*ovcs), GFP_KERNEL);
>>>         if (!ovcs) {
>>> -               kfree(new_fdt);
>>> -               kfree(overlay_tree);
>>> -               ret = -ENOMEM;
>>> -               goto out;
>>> +               return -ENOMEM;
>>>         }
>>>
>>>         of_overlay_mutex_lock();
>>> @@ -945,28 +950,27 @@ static int of_overlay_apply(const void *new_fdt,
>>>
>>>         ret = of_resolve_phandles(overlay_tree);
>>>         if (ret)
>>> -               goto err_free_overlay_tree;
>>> +               goto err_free_ovcs;
>>>
>>> -       ret = init_overlay_changeset(ovcs, new_fdt, overlay_tree);
>>> +       ret = init_overlay_changeset(ovcs, new_fdt, tree_mem, overlay_tree);
>>>         if (ret)
>>> -               goto err_free_overlay_tree;
>>> +               goto err_free_ovcs_contents;
>>>
>>>         /*
>>> -        * after overlay_notify(), ovcs->overlay_tree related pointers may have
>>> -        * leaked to drivers, so can not kfree() overlay_tree,
>>> -        * aka ovcs->overlay_tree; and can not free memory containing aligned
>>> -        * fdt.  The aligned fdt is contained within the memory at
>>> -        * ovcs->new_fdt, possibly at an offset from ovcs->new_fdt.
>>> +        * After overlay_notify(), ovcs->overlay_tree related pointers may have
>>> +        * leaked to drivers, so can not kfree() ovcs->overlay_mem and
>>> +        * ovcs->new_fdt until after OF_OVERLAY_POST_REMOVE notifiers.
>>>          */
>>> +       *kfree_unsafe = true;
>>>         ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
>>>         if (ret) {
>>
>> If OF_OVERLAY_PRE_APPLY failed, I would think kfree would still be okay.
> 
> Not with the existing policy.
> 
> If we tightened up the policy so that the OF_OVERLAY_PRE_APPLY handler is required
> to release all references to the overlay memory even with an error return then the
> kfree would be ok if OF_OVERLAY_PRE_APPLY failed.
> 
>>
>>>                 pr_err("overlay changeset pre-apply notify error %d\n", ret);
>>> -               goto err_free_overlay_changeset;
>>> +               goto err_free_ovcs_contents;
>>>         }
> 

