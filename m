Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24E1504B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 04:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbiDRC5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 22:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbiDRC5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 22:57:23 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98973186CC
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 19:54:45 -0700 (PDT)
Date:   Mon, 18 Apr 2022 02:54:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail2; t=1650250482;
        bh=4/xV+oXMzNlRtmKo/7a61rwcC2Rh4bcYE2JkSFnFgKo=;
        h=Date:To:From:Reply-To:Subject:Message-ID:From:To:Cc:Date:Subject:
         Reply-To:Feedback-ID:Message-ID;
        b=Ovh6ZNTyhr+bn0Bj8TE/BnyXSNxkN4CYny/UFb9Y8AcZ1YO30B9Q0idBaFUhKh2k3
         /AZS7fzo/bC6o6pX3keysnUAPGkJ2QtlHLzNJpJ96iaqA+ozHpSZJWjYk95e/A5c/W
         tVg0CeXQDo5M4Swc3IHupOtgeH90WDZXJ+fNXZrlrUWZhCOKgoQKJ/zAvG3yQzY9Kp
         Owa37Rwi4zhCYf8cP8/BekL4hgJ4fNUxcFKTciZEd7m3Kq6GWuGISy+Wh6cemE3mDA
         D/KL7AdD1RgghQWuCRxLmiozTMqeG5m8/HXvWHoNl/IX6z7afD/GdbBYE9GQlRgIrD
         RsZ52uZfYtx8A==
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
From:   Solomon Tan <solomonbstoner@protonmail.ch>
Reply-To: Solomon Tan <solomonbstoner@protonmail.ch>
Subject: [PATCH 1/2] virtio: Replace unsigned with unsigned int
Message-ID: <YlzS49Wo8JMDhKOt@ArchDesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses the checkpatch.pl warning where unsigned int is
preferred over unsigned.

Signed-off-by: Solomon Tan <solomonbstoner@protonmail.ch>
---
 drivers/virtio/virtio.c            |  2 +-
 drivers/virtio/virtio_balloon.c    | 12 ++++++------
 drivers/virtio/virtio_mmio.c       | 12 ++++++------
 drivers/virtio/virtio_pci_common.c | 12 ++++++------
 drivers/virtio/virtio_pci_common.h | 10 +++++-----
 drivers/virtio/virtio_pci_legacy.c | 10 +++++-----
 drivers/virtio/virtio_pci_modern.c | 12 ++++++------
 drivers/virtio/virtio_ring.c       | 12 ++++++------
 drivers/virtio/virtio_vdpa.c       | 10 +++++-----
 9 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 22f15f444f75..ce424c16997d 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -169,7 +169,7 @@ EXPORT_SYMBOL_GPL(virtio_add_status);
 /* Do some validation, then set FEATURES_OK */
 static int virtio_features_ok(struct virtio_device *dev)
 {
-=09unsigned status;
+=09unsigned int status;
 =09int ret;

 =09might_sleep();
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloo=
n.c
index f4c34a2a6b8e..b9737da6c4dd 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -27,7 +27,7 @@
  * multiple balloon pages.  All memory counters in this driver are in ball=
oon
  * page units.
  */
-#define VIRTIO_BALLOON_PAGES_PER_PAGE (unsigned)(PAGE_SIZE >> VIRTIO_BALLO=
ON_PFN_SHIFT)
+#define VIRTIO_BALLOON_PAGES_PER_PAGE (unsigned int)(PAGE_SIZE >> VIRTIO_B=
ALLOON_PFN_SHIFT)
 #define VIRTIO_BALLOON_ARRAY_PFNS_MAX 256
 /* Maximum number of (4k) pages to deflate on OOM notifications. */
 #define VIRTIO_BALLOON_OOM_NR_PAGES 256
@@ -208,10 +208,10 @@ static void set_page_pfns(struct virtio_balloon *vb,
 =09=09=09=09=09  page_to_balloon_pfn(page) + i);
 }

-static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
+static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 {
-=09unsigned num_allocated_pages;
-=09unsigned num_pfns;
+=09unsigned int num_allocated_pages;
+=09unsigned int num_pfns;
 =09struct page *page;
 =09LIST_HEAD(pages);

@@ -272,9 +272,9 @@ static void release_pages_balloon(struct virtio_balloon=
 *vb,
 =09}
 }

-static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
+static unsigned int leak_balloon(struct virtio_balloon *vb, size_t num)
 {
-=09unsigned num_freed_pages;
+=09unsigned int num_freed_pages;
 =09struct page *page;
 =09struct balloon_dev_info *vb_dev_info =3D &vb->vb_dev_info;
 =09LIST_HEAD(pages);
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 56128b9c46eb..b717302dc4ac 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -144,8 +144,8 @@ static int vm_finalize_features(struct virtio_device *v=
dev)
 =09return 0;
 }

-static void vm_get(struct virtio_device *vdev, unsigned offset,
-=09=09   void *buf, unsigned len)
+static void vm_get(struct virtio_device *vdev, unsigned int offset,
+=09=09   void *buf, unsigned int len)
 {
 =09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
 =09void __iomem *base =3D vm_dev->base + VIRTIO_MMIO_CONFIG;
@@ -186,8 +186,8 @@ static void vm_get(struct virtio_device *vdev, unsigned=
 offset,
 =09}
 }

-static void vm_set(struct virtio_device *vdev, unsigned offset,
-=09=09   const void *buf, unsigned len)
+static void vm_set(struct virtio_device *vdev, unsigned int offset,
+=09=09   const void *buf, unsigned int len)
 {
 =09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
 =09void __iomem *base =3D vm_dev->base + VIRTIO_MMIO_CONFIG;
@@ -345,7 +345,7 @@ static void vm_del_vqs(struct virtio_device *vdev)
 =09free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
 }

-static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned =
index,
+static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned =
int index,
 =09=09=09=09  void (*callback)(struct virtqueue *vq),
 =09=09=09=09  const char *name, bool ctx)
 {
@@ -455,7 +455,7 @@ static struct virtqueue *vm_setup_vq(struct virtio_devi=
ce *vdev, unsigned index,
 =09return ERR_PTR(err);
 }

-static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 =09=09       struct virtqueue *vqs[],
 =09=09       vq_callback_t *callbacks[],
 =09=09       const char * const names[],
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci=
_common.c
index d724f676608b..ed985b421740 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -104,8 +104,8 @@ static int vp_request_msix_vectors(struct virtio_device=
 *vdev, int nvectors,
 {
 =09struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
 =09const char *name =3D dev_name(&vp_dev->vdev.dev);
-=09unsigned flags =3D PCI_IRQ_MSIX;
-=09unsigned i, v;
+=09unsigned int flags =3D PCI_IRQ_MSIX;
+=09unsigned int i, v;
 =09int err =3D -ENOMEM;

 =09vp_dev->msix_vectors =3D nvectors;
@@ -171,7 +171,7 @@ static int vp_request_msix_vectors(struct virtio_device=
 *vdev, int nvectors,
 =09return err;
 }

-static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned =
index,
+static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned =
int index,
 =09=09=09=09     void (*callback)(struct virtqueue *vq),
 =09=09=09=09     const char *name,
 =09=09=09=09     bool ctx,
@@ -276,7 +276,7 @@ void vp_del_vqs(struct virtio_device *vdev)
 =09vp_dev->vqs =3D NULL;
 }

-static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
+static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 =09=09struct virtqueue *vqs[], vq_callback_t *callbacks[],
 =09=09const char * const names[], bool per_vq_vectors,
 =09=09const bool *ctx,
@@ -350,7 +350,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev,=
 unsigned nvqs,
 =09return err;
 }

-static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
+static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 =09=09struct virtqueue *vqs[], vq_callback_t *callbacks[],
 =09=09const char * const names[], const bool *ctx)
 {
@@ -389,7 +389,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev,=
 unsigned nvqs,
 }

 /* the config->find_vqs() implementation */
-int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 =09=09struct virtqueue *vqs[], vq_callback_t *callbacks[],
 =09=09const char * const names[], const bool *ctx,
 =09=09struct irq_affinity *desc)
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci=
_common.h
index eb17a29fc7ef..23112d84218f 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -38,7 +38,7 @@ struct virtio_pci_vq_info {
 =09struct list_head node;

 =09/* MSI-X vector (or none) */
-=09unsigned msix_vector;
+=09unsigned int msix_vector;
 };

 /* Our device structure */
@@ -68,16 +68,16 @@ struct virtio_pci_device {
 =09 * and I'm too lazy to allocate each name separately. */
 =09char (*msix_names)[256];
 =09/* Number of available vectors */
-=09unsigned msix_vectors;
+=09unsigned int msix_vectors;
 =09/* Vectors allocated, excluding per-vq vectors if any */
-=09unsigned msix_used_vectors;
+=09unsigned int msix_used_vectors;

 =09/* Whether we have vector per vq */
 =09bool per_vq_vectors;

 =09struct virtqueue *(*setup_vq)(struct virtio_pci_device *vp_dev,
 =09=09=09=09      struct virtio_pci_vq_info *info,
-=09=09=09=09      unsigned idx,
+=09=09=09=09      unsigned int idx,
 =09=09=09=09      void (*callback)(struct virtqueue *vq),
 =09=09=09=09      const char *name,
 =09=09=09=09      bool ctx,
@@ -108,7 +108,7 @@ bool vp_notify(struct virtqueue *vq);
 /* the config->del_vqs() implementation */
 void vp_del_vqs(struct virtio_device *vdev);
 /* the config->find_vqs() implementation */
-int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 =09=09struct virtqueue *vqs[], vq_callback_t *callbacks[],
 =09=09const char * const names[], const bool *ctx,
 =09=09struct irq_affinity *desc);
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci=
_legacy.c
index 6f4e34ce96b8..7fe4caa4b519 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -45,8 +45,8 @@ static int vp_finalize_features(struct virtio_device *vde=
v)
 }

 /* virtio config->get() implementation */
-static void vp_get(struct virtio_device *vdev, unsigned offset,
-=09=09   void *buf, unsigned len)
+static void vp_get(struct virtio_device *vdev, unsigned int offset,
+=09=09   void *buf, unsigned int len)
 {
 =09struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
 =09void __iomem *ioaddr =3D vp_dev->ldev.ioaddr +
@@ -61,8 +61,8 @@ static void vp_get(struct virtio_device *vdev, unsigned o=
ffset,

 /* the config->set() implementation.  it's symmetric to the config->get()
  * implementation */
-static void vp_set(struct virtio_device *vdev, unsigned offset,
-=09=09   const void *buf, unsigned len)
+static void vp_set(struct virtio_device *vdev, unsigned int offset,
+=09=09   const void *buf, unsigned int len)
 {
 =09struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
 =09void __iomem *ioaddr =3D vp_dev->ldev.ioaddr +
@@ -109,7 +109,7 @@ static u16 vp_config_vector(struct virtio_pci_device *v=
p_dev, u16 vector)

 static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 =09=09=09=09  struct virtio_pci_vq_info *info,
-=09=09=09=09  unsigned index,
+=09=09=09=09  unsigned int index,
 =09=09=09=09  void (*callback)(struct virtqueue *vq),
 =09=09=09=09  const char *name,
 =09=09=09=09  bool ctx,
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci=
_modern.c
index a2671a20ef77..4acb34409f0b 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -60,8 +60,8 @@ static int vp_finalize_features(struct virtio_device *vde=
v)
 }

 /* virtio config->get() implementation */
-static void vp_get(struct virtio_device *vdev, unsigned offset,
-=09=09   void *buf, unsigned len)
+static void vp_get(struct virtio_device *vdev, unsigned int offset,
+=09=09   void *buf, unsigned int len)
 {
 =09struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
 =09struct virtio_pci_modern_device *mdev =3D &vp_dev->mdev;
@@ -98,8 +98,8 @@ static void vp_get(struct virtio_device *vdev, unsigned o=
ffset,

 /* the config->set() implementation.  it's symmetric to the config->get()
  * implementation */
-static void vp_set(struct virtio_device *vdev, unsigned offset,
-=09=09   const void *buf, unsigned len)
+static void vp_set(struct virtio_device *vdev, unsigned int offset,
+=09=09   const void *buf, unsigned int len)
 {
 =09struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
 =09struct virtio_pci_modern_device *mdev =3D &vp_dev->mdev;
@@ -183,7 +183,7 @@ static u16 vp_config_vector(struct virtio_pci_device *v=
p_dev, u16 vector)

 static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 =09=09=09=09  struct virtio_pci_vq_info *info,
-=09=09=09=09  unsigned index,
+=09=09=09=09  unsigned int index,
 =09=09=09=09  void (*callback)(struct virtqueue *vq),
 =09=09=09=09  const char *name,
 =09=09=09=09  bool ctx,
@@ -248,7 +248,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_dev=
ice *vp_dev,
 =09return ERR_PTR(err);
 }

-static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned int nvq=
s,
 =09=09=09      struct virtqueue *vqs[],
 =09=09=09      vq_callback_t *callbacks[],
 =09=09=09      const char * const names[], const bool *ctx,
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cfb028ca238e..131b3576e2cc 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -811,7 +811,7 @@ static void virtqueue_disable_cb_split(struct virtqueue=
 *_vq)
 =09}
 }

-static unsigned virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
+static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_v=
q)
 {
 =09struct vring_virtqueue *vq =3D to_vvq(_vq);
 =09u16 last_used_idx;
@@ -836,7 +836,7 @@ static unsigned virtqueue_enable_cb_prepare_split(struc=
t virtqueue *_vq)
 =09return last_used_idx;
 }

-static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned last_used=
_idx)
+static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned int last_=
used_idx)
 {
 =09struct vring_virtqueue *vq =3D to_vvq(_vq);

@@ -1488,7 +1488,7 @@ static void virtqueue_disable_cb_packed(struct virtqu=
eue *_vq)
 =09}
 }

-static unsigned virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
+static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_=
vq)
 {
 =09struct vring_virtqueue *vq =3D to_vvq(_vq);

@@ -2027,7 +2027,7 @@ EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
  * Caller must ensure we don't call this with other virtqueue
  * operations at the same time (except where noted).
  */
-unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
+unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
 {
 =09struct vring_virtqueue *vq =3D to_vvq(_vq);

@@ -2048,7 +2048,7 @@ EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
  *
  * This does not need to be serialized.
  */
-bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
+bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
 {
 =09struct vring_virtqueue *vq =3D to_vvq(_vq);

@@ -2074,7 +2074,7 @@ EXPORT_SYMBOL_GPL(virtqueue_poll);
  */
 bool virtqueue_enable_cb(struct virtqueue *_vq)
 {
-=09unsigned last_used_idx =3D virtqueue_enable_cb_prepare(_vq);
+=09unsigned int last_used_idx =3D virtqueue_enable_cb_prepare(_vq);

 =09return !virtqueue_poll(_vq, last_used_idx);
 }
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 76504559bc25..8f992e417483 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -53,16 +53,16 @@ static struct vdpa_device *vd_get_vdpa(struct virtio_de=
vice *vdev)
 =09return to_virtio_vdpa_device(vdev)->vdpa;
 }

-static void virtio_vdpa_get(struct virtio_device *vdev, unsigned offset,
-=09=09=09    void *buf, unsigned len)
+static void virtio_vdpa_get(struct virtio_device *vdev, unsigned int offse=
t,
+=09=09=09    void *buf, unsigned int len)
 {
 =09struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);

 =09vdpa_get_config(vdpa, offset, buf, len);
 }

-static void virtio_vdpa_set(struct virtio_device *vdev, unsigned offset,
-=09=09=09    const void *buf, unsigned len)
+static void virtio_vdpa_set(struct virtio_device *vdev, unsigned int offse=
t,
+=09=09=09    const void *buf, unsigned int len)
 {
 =09struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);

@@ -263,7 +263,7 @@ static void virtio_vdpa_del_vqs(struct virtio_device *v=
dev)
 =09=09virtio_vdpa_del_vq(vq);
 }

-static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int n=
vqs,
 =09=09=09=09struct virtqueue *vqs[],
 =09=09=09=09vq_callback_t *callbacks[],
 =09=09=09=09const char * const names[],
--
2.35.3


