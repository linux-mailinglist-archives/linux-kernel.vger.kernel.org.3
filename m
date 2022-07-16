Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA5D576B89
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 05:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiGPDyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 23:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiGPDyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 23:54:10 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094EA30F4A;
        Fri, 15 Jul 2022 20:54:08 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 18so2122757vkz.2;
        Fri, 15 Jul 2022 20:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ExClA7Ke7uw/olXfsytpe6jQ5KRUs2xstehc67yEv5E=;
        b=XaX9zMzxFz3LXwhwfdyO2z+TnnTj3emgSTO4eDKlq6iWTyLQJckY2nl3oRJQkHlSka
         duFB8PSaBqKE6N4W878WdCaBwygOh6hr+cHL3KZsPTEzt+OVNKiU4EcY6ox4oQAQKZcb
         EiilhOrV0OHmI76fNgjhsKKmu3XqnfUzHnyGNjIkpdV2UsqMkM618RQMSHCZHXE1zN8l
         rTIKXylm4pzsIt2LpVXSl1I2ut8cjBZvbBj87Lf/oHEYsXjmWU6r3viH57zeGWbYcUGe
         1QZ8V5cVwkc9nMRQWiHYzCA/WHzGsQtN9XJo6crVWakrBtvNW3CwQRv75TZOgpLtKg/R
         fTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ExClA7Ke7uw/olXfsytpe6jQ5KRUs2xstehc67yEv5E=;
        b=6OzH36LI1yX8NQIeKoxA31LwrFqsvw4a/UKsBy63xZQcP1u3mGtp1XI1bYYzLZIU9U
         gebPMvSOkVx8v7IBnxJ26nIo9izQ+VZOZYfZNm4ODi4JQk6ku3HPeD7fnMSMyKTNwDtw
         i94ZvR+Ti6CIGL9wp3nG7NNMriFI8xyFHofGbIlS0WCAstwvk5c1qisG4a4KUIJzMNJu
         OVxI4YsmEKybZbGuDy5cg9iNpDn2FGclRTYmYfxO1E8lL2J6VpC8WClxQIUk2ijhwflZ
         anDjgHKxUiJ0JlLIZHDlu84tMIZGgUcu/ivdQO50wEbTMGvDTOTdB0PhjYsluLchG3SC
         5ofA==
X-Gm-Message-State: AJIora+raPTe2udTcx6x3rZVJfPO3ksHDqWlUmw1fRkqaD1M7rcbCg7D
        /jZIwHmJ+pyJkckGSU5nqJo+SayXODM3toeCMMU=
X-Google-Smtp-Source: AGRyM1tN9Vx3jdYsDVE3kN54DpFlMjyj8mZt0Gl4KSSy31w5y9vYbJIC5gvHN9BUY1aLW+L7rM+3PLNo8GAwZYg8kQo=
X-Received: by 2002:a1f:2997:0:b0:374:4bca:e8da with SMTP id
 p145-20020a1f2997000000b003744bcae8damr7048284vkp.4.1657943646901; Fri, 15
 Jul 2022 20:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220630093027.26200-1-yuzhe@nfschina.com> <CAH2r5mvOwRH_N8NuouK=N0yDqcCZD2chxZM=52y11a5-yrZAeg@mail.gmail.com>
In-Reply-To: <CAH2r5mvOwRH_N8NuouK=N0yDqcCZD2chxZM=52y11a5-yrZAeg@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 15 Jul 2022 22:53:55 -0500
Message-ID: <CAH2r5muC3f8rXE+TOB9F1dU6TxedNUcS_y16p=Z7CVQaHJ9KxQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: remove unnecessary type castings
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>, liqiong@nfschina.com
Content-Type: multipart/mixed; boundary="00000000000021dd1905e3e4160f"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000021dd1905e3e4160f
Content-Type: text/plain; charset="UTF-8"

And added one more part of which was included in your previous patch
but not this part.


On Fri, Jul 15, 2022 at 10:47 PM Steve French <smfrench@gmail.com> wrote:
>
> merged into cifs-2.6.git for-next
>
> On Thu, Jun 30, 2022 at 4:38 AM Yu Zhe <yuzhe@nfschina.com> wrote:
> >
> > remove unnecessary void* type castings.
> >
> > Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> > ---
> >  fs/cifs/connect.c  | 2 +-
> >  fs/cifs/inode.c    | 4 ++--
> >  fs/cifs/netmisc.c  | 2 +-
> >  fs/cifs/smb2misc.c | 2 +-
> >  fs/cifs/smb2pdu.c  | 2 +-
> >  5 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> > index fa29c9aae24b..90863b3b5204 100644
> > --- a/fs/cifs/connect.c
> > +++ b/fs/cifs/connect.c
> > @@ -2646,7 +2646,7 @@ match_prepath(struct super_block *sb, struct cifs_mnt_data *mnt_data)
> >  int
> >  cifs_match_super(struct super_block *sb, void *data)
> >  {
> > -       struct cifs_mnt_data *mnt_data = (struct cifs_mnt_data *)data;
> > +       struct cifs_mnt_data *mnt_data = data;
> >         struct smb3_fs_context *ctx;
> >         struct cifs_sb_info *cifs_sb;
> >         struct TCP_Server_Info *tcp_srv;
> > diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
> > index 81da81e18553..3ad303dd5e5a 100644
> > --- a/fs/cifs/inode.c
> > +++ b/fs/cifs/inode.c
> > @@ -1223,7 +1223,7 @@ static const struct inode_operations cifs_ipc_inode_ops = {
> >  static int
> >  cifs_find_inode(struct inode *inode, void *opaque)
> >  {
> > -       struct cifs_fattr *fattr = (struct cifs_fattr *) opaque;
> > +       struct cifs_fattr *fattr = opaque;
> >
> >         /* don't match inode with different uniqueid */
> >         if (CIFS_I(inode)->uniqueid != fattr->cf_uniqueid)
> > @@ -1247,7 +1247,7 @@ cifs_find_inode(struct inode *inode, void *opaque)
> >  static int
> >  cifs_init_inode(struct inode *inode, void *opaque)
> >  {
> > -       struct cifs_fattr *fattr = (struct cifs_fattr *) opaque;
> > +       struct cifs_fattr *fattr = opaque;
> >
> >         CIFS_I(inode)->uniqueid = fattr->cf_uniqueid;
> >         CIFS_I(inode)->createtime = fattr->cf_createtime;
> > diff --git a/fs/cifs/netmisc.c b/fs/cifs/netmisc.c
> > index 235aa1b395eb..28caae7aed1b 100644
> > --- a/fs/cifs/netmisc.c
> > +++ b/fs/cifs/netmisc.c
> > @@ -911,7 +911,7 @@ map_and_check_smb_error(struct mid_q_entry *mid, bool logErr)
> >  unsigned int
> >  smbCalcSize(void *buf, struct TCP_Server_Info *server)
> >  {
> > -       struct smb_hdr *ptr = (struct smb_hdr *)buf;
> > +       struct smb_hdr *ptr = buf;
> >         return (sizeof(struct smb_hdr) + (2 * ptr->WordCount) +
> >                 2 /* size of the bcc field */ + get_bcc(ptr));
> >  }
> > diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
> > index 17813c3d0c6e..db0f27fd373b 100644
> > --- a/fs/cifs/smb2misc.c
> > +++ b/fs/cifs/smb2misc.c
> > @@ -402,7 +402,7 @@ smb2_get_data_area_len(int *off, int *len, struct smb2_hdr *shdr)
> >  unsigned int
> >  smb2_calc_size(void *buf, struct TCP_Server_Info *srvr)
> >  {
> > -       struct smb2_pdu *pdu = (struct smb2_pdu *)buf;
> > +       struct smb2_pdu *pdu = buf;
> >         struct smb2_hdr *shdr = &pdu->hdr;
> >         int offset; /* the offset from the beginning of SMB to data area */
> >         int data_length; /* the length of the variable length data area */
> > diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> > index 12b4dddaedb0..92fb513e5478 100644
> > --- a/fs/cifs/smb2pdu.c
> > +++ b/fs/cifs/smb2pdu.c
> > @@ -354,7 +354,7 @@ fill_small_buf(__le16 smb2_command, struct cifs_tcon *tcon,
> >                void *buf,
> >                unsigned int *total_len)
> >  {
> > -       struct smb2_pdu *spdu = (struct smb2_pdu *)buf;
> > +       struct smb2_pdu *spdu = buf;
> >         /* lookup word count ie StructureSize from table */
> >         __u16 parmsize = smb2_req_struct_sizes[le16_to_cpu(smb2_command)];
> >
> > --
> > 2.11.0
> >
>
>
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve

--00000000000021dd1905e3e4160f
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-cifs-remove-unnecessary-void-conversions.patch"
Content-Disposition: attachment; 
	filename="0002-cifs-remove-unnecessary-void-conversions.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l5nctl7f0>
X-Attachment-Id: f_l5nctl7f0

RnJvbSAxNDRkZWQ1Y2RhM2VkZDhjYmRhYWIyNWYzNTY2ODhlM2EyY2U0YzIwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdSBaaGUgPHl1emhlQG5mc2NoaW5hLmNvbT4KRGF0ZTogVHVl
LCAxNCBKdW4gMjAyMiAwMTo1NDo0OSAtMDcwMApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBjaWZzOiBy
ZW1vdmUgdW5uZWNlc3NhcnkgKHZvaWQqKSBjb252ZXJzaW9ucy4KCk9uZSBtb3JlLgoKcmVtb3Zl
IHVubmVjZXNzYXJ5IHZvaWQqIHR5cGUgY2FzdGluZ3MuCgpTaWduZWQtb2ZmLWJ5OiBZdSBaaGUg
PHl1emhlQG5mc2NoaW5hLmNvbT4KU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZyZW5j
aEBtaWNyb3NvZnQuY29tPgotLS0KIGZzL2NpZnMvY2lmc19kZWJ1Zy5jIHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnMv
Y2lmcy9jaWZzX2RlYnVnLmMgYi9mcy9jaWZzL2NpZnNfZGVidWcuYwppbmRleCAyY2ZiYWM4YmI5
NjUuLjk3MTE2YzE3MTBlMiAxMDA2NDQKLS0tIGEvZnMvY2lmcy9jaWZzX2RlYnVnLmMKKysrIGIv
ZnMvY2lmcy9jaWZzX2RlYnVnLmMKQEAgLTM2LDcgKzM2LDcgQEAgY2lmc19kdW1wX21lbShjaGFy
ICpsYWJlbCwgdm9pZCAqZGF0YSwgaW50IGxlbmd0aCkKIHZvaWQgY2lmc19kdW1wX2RldGFpbCh2
b2lkICpidWYsIHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNlcnZlcikKIHsKICNpZmRlZiBDT05G
SUdfQ0lGU19ERUJVRzIKLQlzdHJ1Y3Qgc21iX2hkciAqc21iID0gKHN0cnVjdCBzbWJfaGRyICop
YnVmOworCXN0cnVjdCBzbWJfaGRyICpzbWIgPSBidWY7CiAKIAljaWZzX2RiZyhWRlMsICJDbWQ6
ICVkIEVycjogMHgleCBGbGFnczogMHgleCBGbGdzMjogMHgleCBNaWQ6ICVkIFBpZDogJWRcbiIs
CiAJCSBzbWItPkNvbW1hbmQsIHNtYi0+U3RhdHVzLkNpZnNFcnJvciwKLS0gCjIuMzQuMQoK
--00000000000021dd1905e3e4160f--
