Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5644F5543C4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352618AbiFVHXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352562AbiFVHXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:23:16 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075C236B4E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:23:15 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3176b6ed923so153750227b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1U8jCjMoXNVk9HWYXjDTHGrxje8akXXdsFZlKxx2GI8=;
        b=kYk2bdmek0PxdWzontTBS4EE7nWncjrq0C89WdeBZPum9WzggdWx3aqMmkb3NPTjiJ
         qmmRrJWjUzsbo0QT27AqEIz3LNh/B3ub7qUhQTzNDYcswoK4TX4I9Gfp827Mci56qkj1
         VC5dtjCPOE4aOd9xZ0rEwV64oI0WWfX6WK8UX5k0hc7QucI3l+beoT9urj/slD7/UP+P
         XJoNPL3gnL5G8KHymqdvuG+SVqdWb5FBtLbSn4erPpfFl0h1IIJoXAS1lpBH3eajYNBA
         WLwJYyWdQ7Jcoc2cMUG1Z6LAWCC4iTiZ3kLE2HBT4S+Rk28qi7RM+otFU+SHAbLTOe5M
         9mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1U8jCjMoXNVk9HWYXjDTHGrxje8akXXdsFZlKxx2GI8=;
        b=KChcx1FxjnKSgF+JY6ZoYEylZaN/HO8ETSr3Sw3cXrSeOgy69E4sjeowIEIQ6Xe90d
         WHuRRIAxd0ODAHc0yVgTPoxtxWummT/3pcpM7DLP59hFoubV7atyBeIeJF0vbnJx2Ufs
         9tC0TEANLrfmVzMEpmRCBn5dC6zekMOw+ceQ+prEM2yx8loytm46ZT5JmLCccFwoX/uG
         4vgM5so8qDWVwrwzlDG8EJDlDM9ELq70ddCGabB6V+CFrh/p2blN+HDqZeGnGilN6kH6
         GN/YvWWovZg4r/qzui3+R4e5e6oUZ2vdIwMKaP7vPt2/ME2FSr0yZ86MvyOTHv05BHX8
         Srpg==
X-Gm-Message-State: AJIora8l9WhAgBFz93L6B9DFhZTuQ/ZXVMoANwywSi56JZ1QHyu45t1V
        8TbiU1WAZtRF2kfNqYaskEcRkVLcsc1i16xWoMdmxz6Nn2QRlpPt
X-Google-Smtp-Source: AGRyM1uUI7PDvm41+XIJLqBF4p8Jg7KHNWNFdOly33yiBqTRqPLMjcjwSMdIXw68fEg+9TQDMvNpjG4r4kMXvWFpkq4=
X-Received: by 2002:a81:4bc5:0:b0:317:9c15:6ceb with SMTP id
 y188-20020a814bc5000000b003179c156cebmr2538113ywa.31.1655882594231; Wed, 22
 Jun 2022 00:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220622153815.6f2e671a@canb.auug.org.au>
In-Reply-To: <20220622153815.6f2e671a@canb.auug.org.au>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 22 Jun 2022 15:22:35 +0800
Message-ID: <CAMZfGtVQr=7pUevVbbNK9teskfGsjcoif2sfHQ-YrDx5qHNiXg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mm tree with the folio tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000d21df005e2043511"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d21df005e2043511
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 22, 2022 at 1:38 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the mm tree got a conflict in:
>
>   mm/vmscan.c
>
> between commit:
>
>   15077be8badc ("vmscan: Add check_move_unevictable_folios()")

Sorry for the conflicts, I didn't see this change in the mm-unstable branch
yesterday. Based on this commit, I have reworked the following commit
(see attachment, mainly changes are about check_move_unevictable_folios()).
Andrew can pick it up if he wants to replace the original patch with
the new one.

>
> from the folio tree and commits:
>
>   cca700a8e695 ("mm: lru: use lruvec lock to serialize memcg changes")
>
> from the mm tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc mm/vmscan.c
> index 04f8671caad9,60335f974803..000000000000
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@@ -4823,18 -4856,22 +4873,17 @@@ void check_move_unevictable_folios(stru
>         int pgrescued = 0;
>         int i;
>
>  -      for (i = 0; i < pvec->nr; i++) {
>  -              struct page *page = pvec->pages[i];
>  -              struct folio *folio = page_folio(page);
>  -              int nr_pages;
>  -
>  -              if (PageTransTail(page))
>  -                      continue;
>  +      for (i = 0; i < fbatch->nr; i++) {
>  +              struct folio *folio = fbatch->folios[i];
>  +              int nr_pages = folio_nr_pages(folio);
>
>  -              nr_pages = folio_nr_pages(folio);
>                 pgscanned += nr_pages;
>
> -               /* block memcg migration while the folio moves between lrus */
> -               if (!folio_test_clear_lru(folio))
> +               lruvec = folio_lruvec_relock_irq(folio, lruvec);
> +               if (!folio_test_lru(folio) || !folio_test_unevictable(folio))
>                         continue;
>
> -               lruvec = folio_lruvec_relock_irq(folio, lruvec);
> -               if (folio_evictable(folio) && folio_test_unevictable(folio)) {
> +               if (folio_evictable(folio)) {
>                         lruvec_del_folio(lruvec, folio);
>                         folio_clear_unevictable(folio);
>                         lruvec_add_folio(lruvec, folio);

The above fix is no problem. But I have something to confirm since I
do not see the next lines of the code.  There is a "folio_set_lru(folio);"
in the end of this if branch, it should be removed as well.

Thanks.

--000000000000d21df005e2043511
Content-Type: application/octet-stream; 
	name="0001-mm-lru-use-lruvec-lock-to-serialize-memcg-changes.patch"
Content-Disposition: attachment; 
	filename="0001-mm-lru-use-lruvec-lock-to-serialize-memcg-changes.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l4p9cbhj0>
X-Attachment-Id: f_l4p9cbhj0

RnJvbSA1ZDJhNDFjYjJkMTRjOTc1Y2ZiNTI1ODhkMmUyYTU3ODM3MjM4OTIwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNdWNodW4gU29uZyA8c29uZ211Y2h1bkBieXRlZGFuY2UuY29t
PgpEYXRlOiBNb24sIDUgQXByIDIwMjEgMTc6Mjg6MDQgKzA4MDAKU3ViamVjdDogW1BBVENIXSBt
bTogbHJ1OiB1c2UgbHJ1dmVjIGxvY2sgdG8gc2VyaWFsaXplIG1lbWNnIGNoYW5nZXMKCkFzIGRl
c2NyaWJlZCBieSBjb21taXQgZmM1NzRjMjM1NThjICgibW0vc3dhcC5jOiBzZXJpYWxpemUgbWVt
Y2cKY2hhbmdlcyBpbiBwYWdldmVjX2xydV9tb3ZlX2ZuIiksIFRlc3RDbGVhclBhZ2VMUlUoKSBh
aW1zIHRvCnNlcmlhbGl6ZSBtZW1fY2dyb3VwX21vdmVfYWNjb3VudCgpIGR1cmluZyBwYWdldmVj
X2xydV9tb3ZlX2ZuKCkuCk5vdyBmb2xpb19scnV2ZWNfbG9jayooKSBoYXMgdGhlIGFiaWxpdHkg
dG8gZGV0ZWN0IHdoZXRoZXIgcGFnZQptZW1jZyBoYXMgYmVlbiBjaGFuZ2VkLiBTbyB3ZSBjYW4g
dXNlIGxydXZlYyBsb2NrIHRvIHNlcmlhbGl6ZQptZW1fY2dyb3VwX21vdmVfYWNjb3VudCgpIGR1
cmluZyBwYWdldmVjX2xydV9tb3ZlX2ZuKCkuIFRoaXMKY2hhbmdlIGlzIGEgcGFydGlhbCByZXZl
cnQgb2YgdGhlIGNvbW1pdCBmYzU3NGMyMzU1OGMgKCJtbS9zd2FwLmM6CnNlcmlhbGl6ZSBtZW1j
ZyBjaGFuZ2VzIGluIHBhZ2V2ZWNfbHJ1X21vdmVfZm4iKS4KCkFuZCBwYWdldmVjX2xydV9tb3Zl
X2ZuKCkgaXMgbW9yZSBob3QgY29tcGFyZSB3aXRoCm1lbV9jZ3JvdXBfbW92ZV9hY2NvdW50KCks
IHJlbW92aW5nIGFuIGF0b21pYyBvcGVyYXRpb24gd291bGQgYmUKYW4gb3B0aW1pemF0aW9uLiBB
bHNvIHRoaXMgY2hhbmdlIHdvdWxkIG5vdCBkaXJ0eSBjYWNoZWxpbmUgZm9yIGEKcGFnZSB3aGlj
aCBpc24ndCBvbiB0aGUgTFJVLgoKU2lnbmVkLW9mZi1ieTogTXVjaHVuIFNvbmcgPHNvbmdtdWNo
dW5AYnl0ZWRhbmNlLmNvbT4KLS0tCiBtbS9tZW1jb250cm9sLmMgfCAzNCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiBtbS9zd2FwLmMgICAgICAgfCAzMiArKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLQogbW0vdm1zY2FuLmMgICAgIHwgIDcgKystLS0tLQogMyBmaWxl
cyBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9tbS9tZW1jb250cm9sLmMgYi9tbS9tZW1jb250cm9sLmMKaW5kZXggODAzZGJkZjVmMjMzLi44
NWFkYzQzYzVhMjUgMTAwNjQ0Ci0tLSBhL21tL21lbWNvbnRyb2wuYworKysgYi9tbS9tZW1jb250
cm9sLmMKQEAgLTEzMzAsMTAgKzEzMzAsMzkgQEAgc3RydWN0IGxydXZlYyAqZm9saW9fbHJ1dmVj
X2xvY2soc3RydWN0IGZvbGlvICpmb2xpbykKIAlscnV2ZWMgPSBmb2xpb19scnV2ZWMoZm9saW8p
OwogCXNwaW5fbG9jaygmbHJ1dmVjLT5scnVfbG9jayk7CiAKKwkvKgorCSAqIFRoZSBtZW1jZyBv
ZiB0aGUgcGFnZSBjYW4gYmUgY2hhbmdlZCBieSBhbnkgdGhlIGZvbGxvd2luZyByb3V0aW5lczoK
KwkgKgorCSAqIDEpIG1lbV9jZ3JvdXBfbW92ZV9hY2NvdW50KCkgb3IKKwkgKiAyKSBtZW1jZ19y
ZXBhcmVudF9vYmpjZ3MoKQorCSAqCisJICogVGhlIHBvc3NpYmxlIGJhZCBzY2VuYXJpbyB3b3Vs
ZCBsaWtlOgorCSAqCisJICogQ1BVMDogICAgICAgICAgICAgICAgQ1BVMTogICAgICAgICAgICAg
ICAgQ1BVMjoKKwkgKiBscnV2ZWMgPSBmb2xpb19scnV2ZWMoKQorCSAqCisJICogICAgICAgICAg
ICAgICAgICAgICAgaWYgKCFpc29sYXRlX2xydV9wYWdlKCkpCisJICogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBtZW1fY2dyb3VwX21vdmVfYWNjb3VudCgpCisJICoKKwkgKiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtZW1jZ19yZXBhcmVudF9vYmpjZ3Mo
KQorCSAqCisJICogc3Bpbl9sb2NrKCZscnV2ZWMtPmxydV9sb2NrKQorCSAqICAgICAgICAgICAg
ICAgIF5eXl5eXgorCSAqICAgICAgICAgICAgICB3cm9uZyBsb2NrCisJICoKKwkgKiBFaXRoZXIg
Q1BVMSBvciBDUFUyIGNhbiBjaGFuZ2UgcGFnZSBtZW1jZywgc28gd2UgbmVlZCB0byBjaGVjawor
CSAqIHdoZXRoZXIgcGFnZSBtZW1jZyBpcyBjaGFuZ2VkLCBpZiBzbywgd2Ugc2hvdWxkIHJlYWNx
dWlyZSB0aGUKKwkgKiBuZXcgbHJ1dmVjIGxvY2suCisJICovCiAJaWYgKHVubGlrZWx5KGxydXZl
Y19tZW1jZyhscnV2ZWMpICE9IGZvbGlvX21lbWNnKGZvbGlvKSkpIHsKIAkJc3Bpbl91bmxvY2so
JmxydXZlYy0+bHJ1X2xvY2spOwogCQlnb3RvIHJldHJ5OwogCX0KKworCS8qCisJICogV2hlbiB3
ZSByZWFjaCBoZXJlLCBpdCBtZWFucyB0aGF0IHRoZSBmb2xpb19tZW1jZyhmb2xpbykgaXMKKwkg
KiBzdGFibGUuCisJICovCiAJcmN1X3JlYWRfdW5sb2NrKCk7CiAKIAlyZXR1cm4gbHJ1dmVjOwpA
QCAtMTM2MSw2ICsxMzkwLDcgQEAgc3RydWN0IGxydXZlYyAqZm9saW9fbHJ1dmVjX2xvY2tfaXJx
KHN0cnVjdCBmb2xpbyAqZm9saW8pCiAJbHJ1dmVjID0gZm9saW9fbHJ1dmVjKGZvbGlvKTsKIAlz
cGluX2xvY2tfaXJxKCZscnV2ZWMtPmxydV9sb2NrKTsKIAorCS8qIFNlZSB0aGUgY29tbWVudHMg
aW4gZm9saW9fbHJ1dmVjX2xvY2soKS4gKi8KIAlpZiAodW5saWtlbHkobHJ1dmVjX21lbWNnKGxy
dXZlYykgIT0gZm9saW9fbWVtY2coZm9saW8pKSkgewogCQlzcGluX3VubG9ja19pcnEoJmxydXZl
Yy0+bHJ1X2xvY2spOwogCQlnb3RvIHJldHJ5OwpAQCAtMTM5NCw2ICsxNDI0LDcgQEAgc3RydWN0
IGxydXZlYyAqZm9saW9fbHJ1dmVjX2xvY2tfaXJxc2F2ZShzdHJ1Y3QgZm9saW8gKmZvbGlvLAog
CWxydXZlYyA9IGZvbGlvX2xydXZlYyhmb2xpbyk7CiAJc3Bpbl9sb2NrX2lycXNhdmUoJmxydXZl
Yy0+bHJ1X2xvY2ssICpmbGFncyk7CiAKKwkvKiBTZWUgdGhlIGNvbW1lbnRzIGluIGZvbGlvX2xy
dXZlY19sb2NrKCkuICovCiAJaWYgKHVubGlrZWx5KGxydXZlY19tZW1jZyhscnV2ZWMpICE9IGZv
bGlvX21lbWNnKGZvbGlvKSkpIHsKIAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbHJ1dmVjLT5s
cnVfbG9jaywgKmZsYWdzKTsKIAkJZ290byByZXRyeTsKQEAgLTU4MDksNyArNTg0MCwxMCBAQCBz
dGF0aWMgaW50IG1lbV9jZ3JvdXBfbW92ZV9hY2NvdW50KHN0cnVjdCBwYWdlICpwYWdlLAogCW9i
al9jZ3JvdXBfcHV0KHJjdV9kZXJlZmVyZW5jZShmcm9tLT5vYmpjZykpOwogCXJjdV9yZWFkX3Vu
bG9jaygpOwogCisJLyogU2VlIHRoZSBjb21tZW50cyBpbiBmb2xpb19scnV2ZWNfbG9jaygpLiAq
LworCXNwaW5fbG9jaygmZnJvbV92ZWMtPmxydV9sb2NrKTsKIAlmb2xpby0+bWVtY2dfZGF0YSA9
ICh1bnNpZ25lZCBsb25nKXJjdV9hY2Nlc3NfcG9pbnRlcih0by0+b2JqY2cpOworCXNwaW5fdW5s
b2NrKCZmcm9tX3ZlYy0+bHJ1X2xvY2spOwogCiAJX19mb2xpb19tZW1jZ191bmxvY2soZnJvbSk7
CiAKZGlmZiAtLWdpdCBhL21tL3N3YXAuYyBiL21tL3N3YXAuYwppbmRleCA5ODdkY2JkOTNmZmEu
LjBmYzU5NDA5ZTI3ZCAxMDA2NDQKLS0tIGEvbW0vc3dhcC5jCisrKyBiL21tL3N3YXAuYwpAQCAt
MTk2LDYgKzE5Niw3IEBAIHN0YXRpYyB2b2lkIGxydV9hZGRfZm4oc3RydWN0IGxydXZlYyAqbHJ1
dmVjLCBzdHJ1Y3QgZm9saW8gKmZvbGlvKQogCiAJVk1fQlVHX09OX0ZPTElPKGZvbGlvX3Rlc3Rf
bHJ1KGZvbGlvKSwgZm9saW8pOwogCisJZm9saW9fc2V0X2xydShmb2xpbyk7CiAJLyoKIAkgKiBJ
cyBhbiBzbXBfbWJfX2FmdGVyX2F0b21pYygpIHN0aWxsIHJlcXVpcmVkIGhlcmUsIGJlZm9yZQog
CSAqIGZvbGlvX2V2aWN0YWJsZSgpIHRlc3RzIHRoZSBtbG9ja2VkIGZsYWcsIHRvIHJ1bGUgb3V0
IHRoZSBwb3NzaWJpbGl0eQpAQCAtMjM4LDE0ICsyMzksOCBAQCBzdGF0aWMgdm9pZCBmb2xpb19i
YXRjaF9tb3ZlX2xydShzdHJ1Y3QgZm9saW9fYmF0Y2ggKmZiYXRjaCwgbW92ZV9mbl90IG1vdmVf
Zm4pCiAJZm9yIChpID0gMDsgaSA8IGZvbGlvX2JhdGNoX2NvdW50KGZiYXRjaCk7IGkrKykgewog
CQlzdHJ1Y3QgZm9saW8gKmZvbGlvID0gZmJhdGNoLT5mb2xpb3NbaV07CiAKLQkJLyogYmxvY2sg
bWVtY2cgbWlncmF0aW9uIHdoaWxlIHRoZSBmb2xpbyBtb3ZlcyBiZXR3ZWVuIGxydSAqLwotCQlp
ZiAobW92ZV9mbiAhPSBscnVfYWRkX2ZuICYmICFmb2xpb190ZXN0X2NsZWFyX2xydShmb2xpbykp
Ci0JCQljb250aW51ZTsKLQogCQlscnV2ZWMgPSBmb2xpb19scnV2ZWNfcmVsb2NrX2lycXNhdmUo
Zm9saW8sIGxydXZlYywgJmZsYWdzKTsKIAkJbW92ZV9mbihscnV2ZWMsIGZvbGlvKTsKLQotCQlm
b2xpb19zZXRfbHJ1KGZvbGlvKTsKIAl9CiAKIAlpZiAobHJ1dmVjKQpAQCAtMjY1LDcgKzI2MCw3
IEBAIHN0YXRpYyB2b2lkIGZvbGlvX2JhdGNoX2FkZF9hbmRfbW92ZShzdHJ1Y3QgZm9saW9fYmF0
Y2ggKmZiYXRjaCwKIAogc3RhdGljIHZvaWQgbHJ1X21vdmVfdGFpbF9mbihzdHJ1Y3QgbHJ1dmVj
ICpscnV2ZWMsIHN0cnVjdCBmb2xpbyAqZm9saW8pCiB7Ci0JaWYgKCFmb2xpb190ZXN0X3VuZXZp
Y3RhYmxlKGZvbGlvKSkgeworCWlmIChmb2xpb190ZXN0X2xydShmb2xpbykgJiYgIWZvbGlvX3Rl
c3RfdW5ldmljdGFibGUoZm9saW8pKSB7CiAJCWxydXZlY19kZWxfZm9saW8obHJ1dmVjLCBmb2xp
byk7CiAJCWZvbGlvX2NsZWFyX2FjdGl2ZShmb2xpbyk7CiAJCWxydXZlY19hZGRfZm9saW9fdGFp
bChscnV2ZWMsIGZvbGlvKTsKQEAgLTM0OCw3ICszNDMsOCBAQCB2b2lkIGxydV9ub3RlX2Nvc3Rf
Zm9saW8oc3RydWN0IGZvbGlvICpmb2xpbykKIAogc3RhdGljIHZvaWQgZm9saW9fYWN0aXZhdGVf
Zm4oc3RydWN0IGxydXZlYyAqbHJ1dmVjLCBzdHJ1Y3QgZm9saW8gKmZvbGlvKQogewotCWlmICgh
Zm9saW9fdGVzdF9hY3RpdmUoZm9saW8pICYmICFmb2xpb190ZXN0X3VuZXZpY3RhYmxlKGZvbGlv
KSkgeworCWlmIChmb2xpb190ZXN0X2xydShmb2xpbykgJiYgIWZvbGlvX3Rlc3RfYWN0aXZlKGZv
bGlvKSAmJgorCSAgICAhZm9saW9fdGVzdF91bmV2aWN0YWJsZShmb2xpbykpIHsKIAkJbG9uZyBu
cl9wYWdlcyA9IGZvbGlvX25yX3BhZ2VzKGZvbGlvKTsKIAogCQlscnV2ZWNfZGVsX2ZvbGlvKGxy
dXZlYywgZm9saW8pOwpAQCAtMzk0LDEyICszOTAsOSBAQCBzdGF0aWMgdm9pZCBmb2xpb19hY3Rp
dmF0ZShzdHJ1Y3QgZm9saW8gKmZvbGlvKQogewogCXN0cnVjdCBscnV2ZWMgKmxydXZlYzsKIAot
CWlmIChmb2xpb190ZXN0X2NsZWFyX2xydShmb2xpbykpIHsKLQkJbHJ1dmVjID0gZm9saW9fbHJ1
dmVjX2xvY2tfaXJxKGZvbGlvKTsKLQkJZm9saW9fYWN0aXZhdGVfZm4obHJ1dmVjLCBmb2xpbyk7
Ci0JCWxydXZlY191bmxvY2tfaXJxKGxydXZlYyk7Ci0JCWZvbGlvX3NldF9scnUoZm9saW8pOwot
CX0KKwlscnV2ZWMgPSBmb2xpb19scnV2ZWNfbG9ja19pcnEoZm9saW8pOworCWZvbGlvX2FjdGl2
YXRlX2ZuKGxydXZlYywgZm9saW8pOworCWxydXZlY191bmxvY2tfaXJxKGxydXZlYyk7CiB9CiAj
ZW5kaWYKIApAQCAtNTQyLDYgKzUzNSw5IEBAIHN0YXRpYyB2b2lkIGxydV9kZWFjdGl2YXRlX2Zp
bGVfZm4oc3RydWN0IGxydXZlYyAqbHJ1dmVjLCBzdHJ1Y3QgZm9saW8gKmZvbGlvKQogCWJvb2wg
YWN0aXZlID0gZm9saW9fdGVzdF9hY3RpdmUoZm9saW8pOwogCWxvbmcgbnJfcGFnZXMgPSBmb2xp
b19ucl9wYWdlcyhmb2xpbyk7CiAKKwlpZiAoIWZvbGlvX3Rlc3RfbHJ1KGZvbGlvKSkKKwkJcmV0
dXJuOworCiAJaWYgKGZvbGlvX3Rlc3RfdW5ldmljdGFibGUoZm9saW8pKQogCQlyZXR1cm47CiAK
QEAgLTU4MCw3ICs1NzYsOCBAQCBzdGF0aWMgdm9pZCBscnVfZGVhY3RpdmF0ZV9maWxlX2ZuKHN0
cnVjdCBscnV2ZWMgKmxydXZlYywgc3RydWN0IGZvbGlvICpmb2xpbykKIAogc3RhdGljIHZvaWQg
bHJ1X2RlYWN0aXZhdGVfZm4oc3RydWN0IGxydXZlYyAqbHJ1dmVjLCBzdHJ1Y3QgZm9saW8gKmZv
bGlvKQogewotCWlmIChmb2xpb190ZXN0X2FjdGl2ZShmb2xpbykgJiYgIWZvbGlvX3Rlc3RfdW5l
dmljdGFibGUoZm9saW8pKSB7CisJaWYgKGZvbGlvX3Rlc3RfbHJ1KGZvbGlvKSAmJiBmb2xpb190
ZXN0X2FjdGl2ZShmb2xpbykgJiYKKwkgICAgIWZvbGlvX3Rlc3RfdW5ldmljdGFibGUoZm9saW8p
KSB7CiAJCWxvbmcgbnJfcGFnZXMgPSBmb2xpb19ucl9wYWdlcyhmb2xpbyk7CiAKIAkJbHJ1dmVj
X2RlbF9mb2xpbyhscnV2ZWMsIGZvbGlvKTsKQEAgLTU5Niw4ICs1OTMsOSBAQCBzdGF0aWMgdm9p
ZCBscnVfZGVhY3RpdmF0ZV9mbihzdHJ1Y3QgbHJ1dmVjICpscnV2ZWMsIHN0cnVjdCBmb2xpbyAq
Zm9saW8pCiAKIHN0YXRpYyB2b2lkIGxydV9sYXp5ZnJlZV9mbihzdHJ1Y3QgbHJ1dmVjICpscnV2
ZWMsIHN0cnVjdCBmb2xpbyAqZm9saW8pCiB7Ci0JaWYgKGZvbGlvX3Rlc3RfYW5vbihmb2xpbykg
JiYgZm9saW9fdGVzdF9zd2FwYmFja2VkKGZvbGlvKSAmJgotCSAgICAhZm9saW9fdGVzdF9zd2Fw
Y2FjaGUoZm9saW8pICYmICFmb2xpb190ZXN0X3VuZXZpY3RhYmxlKGZvbGlvKSkgeworCWlmIChm
b2xpb190ZXN0X2xydShmb2xpbykgJiYgZm9saW9fdGVzdF9hbm9uKGZvbGlvKSAmJgorCSAgICBm
b2xpb190ZXN0X3N3YXBiYWNrZWQoZm9saW8pICYmICFmb2xpb190ZXN0X3N3YXBjYWNoZShmb2xp
bykgJiYKKwkgICAgIWZvbGlvX3Rlc3RfdW5ldmljdGFibGUoZm9saW8pKSB7CiAJCWxvbmcgbnJf
cGFnZXMgPSBmb2xpb19ucl9wYWdlcyhmb2xpbyk7CiAKIAkJbHJ1dmVjX2RlbF9mb2xpbyhscnV2
ZWMsIGZvbGlvKTsKZGlmZiAtLWdpdCBhL21tL3Ztc2Nhbi5jIGIvbW0vdm1zY2FuLmMKaW5kZXgg
ZWVlMWRhZDdkNWIyLi5kMTNhYmI5ZDc3MTUgMTAwNjQ0Ci0tLSBhL21tL3Ztc2Nhbi5jCisrKyBi
L21tL3Ztc2Nhbi5jCkBAIC00ODc5LDE4ICs0ODc5LDE1IEBAIHZvaWQgY2hlY2tfbW92ZV91bmV2
aWN0YWJsZV9mb2xpb3Moc3RydWN0IGZvbGlvX2JhdGNoICpmYmF0Y2gpCiAKIAkJcGdzY2FubmVk
ICs9IG5yX3BhZ2VzOwogCi0JCS8qIGJsb2NrIG1lbWNnIG1pZ3JhdGlvbiB3aGlsZSB0aGUgZm9s
aW8gbW92ZXMgYmV0d2VlbiBscnVzICovCi0JCWlmICghZm9saW9fdGVzdF9jbGVhcl9scnUoZm9s
aW8pKQotCQkJY29udGludWU7Ci0KIAkJbHJ1dmVjID0gZm9saW9fbHJ1dmVjX3JlbG9ja19pcnEo
Zm9saW8sIGxydXZlYyk7CisJCWlmICghZm9saW9fdGVzdF9scnUoZm9saW8pKQorCQkJY29udGlu
dWU7CiAJCWlmIChmb2xpb19ldmljdGFibGUoZm9saW8pICYmIGZvbGlvX3Rlc3RfdW5ldmljdGFi
bGUoZm9saW8pKSB7CiAJCQlscnV2ZWNfZGVsX2ZvbGlvKGxydXZlYywgZm9saW8pOwogCQkJZm9s
aW9fY2xlYXJfdW5ldmljdGFibGUoZm9saW8pOwogCQkJbHJ1dmVjX2FkZF9mb2xpbyhscnV2ZWMs
IGZvbGlvKTsKIAkJCXBncmVzY3VlZCArPSBucl9wYWdlczsKIAkJfQotCQlmb2xpb19zZXRfbHJ1
KGZvbGlvKTsKIAl9CiAKIAlpZiAobHJ1dmVjKSB7Ci0tIAoyLjExLjAKCg==
--000000000000d21df005e2043511--
